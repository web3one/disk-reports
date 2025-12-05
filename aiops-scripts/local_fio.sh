#!/bin/bash

# FIO 压测执行脚本 (Linux)
# 用法: ./run_fio_hdd.sh <测试文件路径> [输出目录]

set -e

# 配置
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/$2"

# 原先使用目录参数，现在改为必须指定测试文件路径 (这个是用RBD命令挂载的虚拟磁盘，不是真实的硬盘)
TEST_FILE="$1"
if [ -z "$TEST_FILE" ]; then
    echo "✗ 未指定测试文件路径"
    echo "用法: $0 <测试文件路径> <配置文件路径>"
    echo "可以测试资源如下:"
    rbd showmapped
    exit 1
fi

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
FILE_BASE=$(basename "$TEST_FILE")
OUTPUT_DIR="$3/${FILE_BASE}/${TIMESTAMP}"
RESULT_JSON="$OUTPUT_DIR/fio-results_${TIMESTAMP}.json"
RESULT_MD="$OUTPUT_DIR/fio_benchmark_report_${TIMESTAMP}.md"
FILE_DIR="$(dirname "$TEST_FILE")"

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}FIO 压测执行脚本${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""

# 检查配置文件
if [ ! -f "$CONFIG_FILE" ]; then
    echo -e "${RED}✗ 配置文件不存在: $CONFIG_FILE${NC}"
    exit 1
fi
echo -e "${GREEN}✓ 配置文件: $CONFIG_FILE${NC}"

# 检查 FIO 是否安装
if ! command -v fio &> /dev/null; then
    echo -e "${RED}✗ FIO 未安装${NC}"
    echo "请执行: sudo apt-get install fio"
    exit 1
fi
FIO_VERSION=$(fio --version)
echo -e "${GREEN}✓ FIO 版本: $FIO_VERSION${NC}"

# 准备测试文件所在目录
mkdir -p "$FILE_DIR"
# 若文件不存在，提前创建一个占位文件，fio 会按 size 参数进行扩展/重建
if [ ! -f "$TEST_FILE" ]; then
    : > "$TEST_FILE"
fi
echo -e "${GREEN}✓ 测试文件: $TEST_FILE${NC}"

# 准备输出目录
echo $OUTPUT_DIR
mkdir -p "$OUTPUT_DIR"
echo -e "${GREEN}✓ 输出目录: $OUTPUT_DIR${NC}"

# 提升文件句柄限制
CURRENT_LIMIT=$(ulimit -n)
if [ "$CURRENT_LIMIT" -lt 65536 ]; then
    echo -e "${YELLOW}  当前文件句柄限制: $CURRENT_LIMIT${NC}"
    ulimit -n 65536
    NEW_LIMIT=$(ulimit -n)
    echo -e "${GREEN}  已提升至: $NEW_LIMIT${NC}"
else
    echo -e "${GREEN}✓ 文件句柄限制: $CURRENT_LIMIT${NC}"
fi

# 检查磁盘空间使用文件所在的目录
AVAILABLE_SPACE=$(df "$FILE_DIR" | awk 'NR==2 {print $4}')
REQUIRED_SPACE=300
if [ "$AVAILABLE_SPACE" -lt "$REQUIRED_SPACE" ]; then
    echo -e "${RED}✗ 磁盘空间不足: ${AVAILABLE_SPACE}KB < ${REQUIRED_SPACE}KB${NC}"
    exit 1
fi
echo -e "${GREEN}✓ 磁盘空间充足${NC}"

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}开始执行 FIO 压测${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""

# 启动 Ceph 性能监控（后台运行）
CEPH_MONITOR_DIR="$OUTPUT_DIR/ceph-monitoring"
CEPH_MONITOR_SCRIPT="$SCRIPT_DIR/ceph_perf_monitor.sh"
CEPH_MONITOR_PID=""

if [ -f "$CEPH_MONITOR_SCRIPT" ]; then
    echo -e "${GREEN}✓ 启动 Ceph 性能监控...${NC}"
    chmod +x "$CEPH_MONITOR_SCRIPT"
    # 完全分离后台进程，避免 SSH 挂起
    nohup "$CEPH_MONITOR_SCRIPT" "$CEPH_MONITOR_DIR" 5 > /dev/null 2>&1 </dev/null &
    CEPH_MONITOR_PID=$!
    echo -e "${GREEN}  监控进程 PID: $CEPH_MONITOR_PID${NC}"
    sleep 2  # 等待监控脚本初始化
else
    echo -e "${YELLOW}⚠ Ceph 监控脚本不存在，跳过监控: $CEPH_MONITOR_SCRIPT${NC}"
fi

CMD=(fio "$CONFIG_FILE" --filename="$TEST_FILE" --output="$RESULT_JSON" --output-format=json)
echo -e "${YELLOW}→ 执行命令:$(printf ' %q' "${CMD[@]}") ${NC}"
 "${CMD[@]}"

# 检查 FIO 执行是否成功
FIO_EXIT_CODE=$?

# 停止 Ceph 监控
if [ -n "$CEPH_MONITOR_PID" ] && kill -0 "$CEPH_MONITOR_PID" 2>/dev/null; then
    echo ""
    echo -e "${GREEN}✓ 停止 Ceph 监控进程...${NC}"
    # 先停止子进程（如 iostat）
    pkill -P "$CEPH_MONITOR_PID" 2>/dev/null || true
    # 再停止主监控进程
    kill -TERM "$CEPH_MONITOR_PID" 2>/dev/null || true
    # 等待最多 3 秒
    for i in {1..3}; do
        if ! kill -0 "$CEPH_MONITOR_PID" 2>/dev/null; then
            break
        fi
        sleep 1
    done
    # 如果还没退出，强制杀死
    if kill -0 "$CEPH_MONITOR_PID" 2>/dev/null; then
        kill -9 "$CEPH_MONITOR_PID" 2>/dev/null || true
    fi
fi

if [ $FIO_EXIT_CODE -ne 0 ]; then
    echo -e "${RED}✗ FIO 压测失败${NC}"
    exit 1
fi


echo ""
echo -e "${GREEN}✓ FIO 压测完成${NC}"
echo ""

# 使用 Python 脚本解析结果并生成报告
python3 << PYTHON_SCRIPT
import json
import sys
from pathlib import Path
from datetime import datetime

result_json = "$RESULT_JSON"
result_md = "$RESULT_MD"
TEST_FILE = "$TEST_FILE"
try:
    with open(result_json, 'r') as f:
        data = json.load(f)

    jobs = data.get('jobs', [])
    results = {}
    for job in jobs:
        job_name = job.get('jobname', 'unknown')
        read_stats = job.get('read', {})
        write_stats = job.get('write', {})
        results[job_name] = {
            'read_iops': read_stats.get('iops', 0),
            'read_bw': read_stats.get('bw', 0) / 1024,
            'read_lat_mean': read_stats.get('lat_ns', {}).get('mean', 0) / 1000000,
            'read_lat_stdev': read_stats.get('lat_ns', {}).get('stddev', 0) / 1000000,
            'read_lat_p99': read_stats.get('lat_ns', {}).get('percentile', {}).get('99.000000', 0) / 1000000,
            'read_lat_p9999': read_stats.get('lat_ns', {}).get('percentile', {}).get('99.990000', 0) / 1000000,
            'write_iops': write_stats.get('iops', 0),
            'write_bw': write_stats.get('bw', 0) / 1024,
            'write_lat_mean': write_stats.get('lat_ns', {}).get('mean', 0) / 1000000,
            'write_lat_stdev': write_stats.get('lat_ns', {}).get('stddev', 0) / 1000000,
            'write_lat_p99': write_stats.get('lat_ns', {}).get('percentile', {}).get('99.000000', 0) / 1000000,
            'write_lat_p9999': write_stats.get('lat_ns', {}).get('percentile', {}).get('99.990000', 0) / 1000000,
        }

    # 根据实际作业名称分类
    prepare_jobs = {k: v for k, v in results.items() if 'PREPARE' in k}
    prod_jobs = {k: v for k, v in results.items() if 'PROD' in k}
    rnd_read = {k: v for k, v in results.items() if 'RND-READ' in k or 'LATENCY-RND-READ' in k}
    rnd_write = {k: v for k, v in results.items() if 'RND-WRITE' in k or 'LATENCY-RND-WRITE' in k}
    seq_read = {k: v for k, v in results.items() if 'SEQ-READ' in k}
    seq_write = {k: v for k, v in results.items() if 'SEQ-WRITE' in k}

    md_content = f"""# FIO 压测报告

**报告生成时间**: {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}
**结果文件**: {Path(result_json).name}
**输出目录**: {Path(result_json).parent}
**测试文件**: {TEST_FILE}

---

## 1. 准备阶段 (PREPARE)

| 作业名 | 写入IOPS | 写入吞吐量 (MB/s) | 平均延迟 (ms) | P99 延迟 (ms) | P99.99 延迟 (ms) | 延迟标准差 (ms) |
|-------|---------|----------------|-------------|-------------|----------------|---------------|
"""
    for job_name in sorted(prepare_jobs.keys()):
        r = prepare_jobs[job_name]
        md_content += f"| {job_name} | {r['write_iops']:,.0f} | {r['write_bw']:.2f} | {r['write_lat_mean']:.2f} | {r['write_lat_p99']:.2f} | {r['write_lat_p9999']:.2f} | {r['write_lat_stdev']:.2f} |\n"

    md_content += f"""
---

## 2. 生产环境模拟 (PROD - 混合读写)

| 作业名 | 读取IOPS | 写入IOPS | 读取吞吐量 (MB/s) | 写入吞吐量 (MB/s) | 读平均延迟 (ms) | 写平均延迟 (ms) | 读P99 延迟 (ms) | 写P99 延迟 (ms) |
|-------|---------|---------|----------------|----------------|---------------|---------------|---------------|---------------|
"""
    for job_name in sorted(prod_jobs.keys()):
        r = prod_jobs[job_name]
        md_content += f"| {job_name} | {r['read_iops']:,.0f} | {r['write_iops']:,.0f} | {r['read_bw']:.2f} | {r['write_bw']:.2f} | {r['read_lat_mean']:.2f} | {r['write_lat_mean']:.2f} | {r['read_lat_p99']:.2f} | {r['write_lat_p99']:.2f} |\n"

    md_content += f"""
---

## 3. 延迟测试 - 随机读 (LATENCY-RND-READ-4K)

| 作业名 | IOPS | 吞吐量 (MB/s) | 平均延迟 (ms) | P99 延迟 (ms) | P99.99 延迟 (ms) | 延迟标准差 (ms) |
|-------|------|-------------|-------------|-------------|----------------|---------------|
"""
    for job_name in sorted(rnd_read.keys()):
        r = rnd_read[job_name]
        md_content += f"| {job_name} | {r['read_iops']:,.0f} | {r['read_bw']:.2f} | {r['read_lat_mean']:.2f} | {r['read_lat_p99']:.2f} | {r['read_lat_p9999']:.2f} | {r['read_lat_stdev']:.2f} |\n"

    md_content += f"""
---

## 4. 延迟测试 - 随机写 (LATENCY-RND-WRITE-4K)

| 作业名 | IOPS | 吞吐量 (MB/s) | 平均延迟 (ms) | P99 延迟 (ms) | P99.99 延迟 (ms) | 延迟标准差 (ms) |
|-------|------|-------------|-------------|-------------|----------------|---------------|
"""
    for job_name in sorted(rnd_write.keys()):
        r = rnd_write[job_name]
        md_content += f"| {job_name} | {r['write_iops']:,.0f} | {r['write_bw']:.2f} | {r['write_lat_mean']:.2f} | {r['write_lat_p99']:.2f} | {r['write_lat_p9999']:.2f} | {r['write_lat_stdev']:.2f} |\n"

    md_content += f"""
---

## 5. 顺序读 (SEQ-READ-1M)

| 作业名 | 吞吐量 (MB/s) | 平均延迟 (ms) | P99 延迟 (ms) | P99.99 延迟 (ms) | 延迟标准差 (ms) |
|-------|-------------|-------------|-------------|----------------|---------------|
"""
    for job_name in sorted(seq_read.keys()):
        r = seq_read[job_name]
        md_content += f"| {job_name} | {r['read_bw']:.2f} | {r['read_lat_mean']:.2f} | {r['read_lat_p99']:.2f} | {r['read_lat_p9999']:.2f} | {r['read_lat_stdev']:.2f} |\n"

    md_content += f"""
---

## 6. 顺序写 (SEQ-WRITE-1M)

| 作业名 | 吞吐量 (MB/s) | 平均延迟 (ms) | P99 延迟 (ms) | P99.99 延迟 (ms) | 延迟标准差 (ms) |
|-------|-------------|-------------|-------------|----------------|---------------|
"""
    for job_name in sorted(seq_write.keys()):
        r = seq_write[job_name]
        md_content += f"| {job_name} | {r['write_bw']:.2f} | {r['write_lat_mean']:.2f} | {r['write_lat_p99']:.2f} | {r['write_lat_p9999']:.2f} | {r['write_lat_stdev']:.2f} |\n"

    md_content += f"""
---

## 配置说明

### 全局参数
- **ioengine**: libaio (Linux 异步 I/O)
- **direct**: 1 (直接 I/O，绕过缓存)
- **runtime**: 15 秒 (每个作业的运行时间)
- **ramp_time**: 3 秒 (预热时间，不计入结果)
- **size**: 1GB (每个作业的测试文件大小)

### 测试场景

#### 随机读/写 (RND-*)
- BlockSize: 4KB
- 模式: 随机读写
- 不同的并发度和 iodepth 组合

#### 顺序读/写 (SEQ-*)
- BlockSize: 1MB
- 模式: 顺序读写
- 不同的并发度和 iodepth 组合

### 指标说明

- **IOPS**: 每秒 I/O 操作数（越高越好）
- **吞吐量 (MB/s)**: 每秒传输数据量（越高越好）
- **平均延迟 (Avg Latency)**: 平均响应时间，反映整体流畅度（越低越好）
- **P99 延迟**: 99% 请求的响应时间（越低越好）
- **P99.99 延迟**: 99.99% 请求的响应时间，生产环境生死线
  - HDD 混合池建议 < 500ms
  - 全闪池建议 < 10ms
- **延迟标准差 (Latency Stdev)**: 延迟波动程度，越小越稳定
  - 如果标准差很大，可能存在坏盘或网络抖动问题

---
"""

    with open(result_md, 'w', encoding='utf-8') as f:
        f.write(md_content)

    print(f"✓ 已生成 Markdown 报告: {result_md}")
except Exception as e:
    print(f"✗ 解析结果失败: {e}")
    sys.exit(1)
PYTHON_SCRIPT

# 运行 Ceph 性能分析
CEPH_ANALYZE_SCRIPT="$SCRIPT_DIR/analyze_ceph_perf.sh"
CEPH_ANALYSIS_REPORT="$OUTPUT_DIR/ceph_analysis_report.md"

if [ -d "$CEPH_MONITOR_DIR" ] && [ -f "$CEPH_ANALYZE_SCRIPT" ]; then
    echo ""
    echo -e "${GREEN}========================================${NC}"
    echo -e "${GREEN}分析 Ceph 性能数据${NC}"
    echo -e "${GREEN}========================================${NC}"
    echo ""
    chmod +x "$CEPH_ANALYZE_SCRIPT"
    "$CEPH_ANALYZE_SCRIPT" "$CEPH_MONITOR_DIR" "$CEPH_ANALYSIS_REPORT" || echo -e "${YELLOW}⚠ Ceph 分析失败，但不影响主流程${NC}"
fi

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}✓ 所有操作完成！${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "生成的文件:"
echo "  - JSON 原始数据: $RESULT_JSON"
echo "  - Markdown 报告: $RESULT_MD"
if [ -f "$CEPH_ANALYSIS_REPORT" ]; then
    echo "  - Ceph 性能分析: $CEPH_ANALYSIS_REPORT"
    echo "  - Ceph 监控原始数据: $CEPH_MONITOR_DIR/"
fi
echo ""
echo "查看 FIO 报告: cat $RESULT_MD"
if [ -f "$CEPH_ANALYSIS_REPORT" ]; then
    echo "查看 Ceph 分析: cat $CEPH_ANALYSIS_REPORT"
fi
echo ""
