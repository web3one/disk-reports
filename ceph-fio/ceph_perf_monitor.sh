#!/bin/bash

# Ceph 性能监控脚本 - 在 FIO 压测期间后台运行
# 用法: ./ceph_perf_monitor.sh <输出目录> <监控间隔秒数>

set -e

OUTPUT_DIR="${1:-/tmp/ceph-monitoring}"
MONITOR_INTERVAL="${2:-5}"
IOSTAT_INTERVAL="1"

# 创建输出目录
mkdir -p "$OUTPUT_DIR"

# 日志文件
CEPH_STATUS_LOG="$OUTPUT_DIR/ceph_status.log"
CEPH_OSD_PERF_LOG="$OUTPUT_DIR/ceph_osd_perf.log"
CEPH_OSD_DF_LOG="$OUTPUT_DIR/ceph_osd_df.log"
CEPH_HEALTH_LOG="$OUTPUT_DIR/ceph_health_detail.log"
IOSTAT_LOG="$OUTPUT_DIR/iostat.log"
DMESG_LOG="$OUTPUT_DIR/dmesg_errors.log"
NETWORK_LOG="$OUTPUT_DIR/network_stats.log"
SLOW_OPS_LOG="$OUTPUT_DIR/slow_ops.log"

# PID 文件，用于优雅停止
PID_FILE="$OUTPUT_DIR/monitor.pid"
echo $$ > "$PID_FILE"

# 信号处理 - 优雅退出
trap 'echo "监控脚本收到停止信号，正在退出..."; exit 0' SIGTERM SIGINT

echo "========================================" | tee -a "$CEPH_STATUS_LOG"
echo "Ceph 性能监控启动" | tee -a "$CEPH_STATUS_LOG"
echo "开始时间: $(date '+%Y-%m-%d %H:%M:%S')" | tee -a "$CEPH_STATUS_LOG"
echo "输出目录: $OUTPUT_DIR" | tee -a "$CEPH_STATUS_LOG"
echo "监控间隔: ${MONITOR_INTERVAL}s" | tee -a "$CEPH_STATUS_LOG"
echo "========================================" | tee -a "$CEPH_STATUS_LOG"
echo ""

# 检查 Ceph 命令可用性
CEPH_CMD="ceph"
if ! command -v ceph &> /dev/null; then
    echo "警告: ceph 命令不可用，尝试使用 sudo" | tee -a "$CEPH_STATUS_LOG"
    CEPH_CMD="sudo ceph"
fi

# 测试 Ceph 访问权限
if ! $CEPH_CMD -s &> /dev/null; then
    echo "错误: 无法执行 ceph 命令，请检查权限和配置" | tee -a "$CEPH_STATUS_LOG"
    exit 1
fi

# 后台 iostat 监控（持续运行）
if command -v iostat &> /dev/null; then
    iostat -xz "$IOSTAT_INTERVAL" > "$IOSTAT_LOG" 2>&1 &
    IOSTAT_PID=$!
    echo "✓ iostat 监控已启动 (PID: $IOSTAT_PID)" | tee -a "$CEPH_STATUS_LOG"
else
    echo "警告: iostat 不可用，跳过磁盘 I/O 监控" | tee -a "$CEPH_STATUS_LOG"
    IOSTAT_PID=""
fi

# 主监控循环
ITERATION=0
while true; do
    ITERATION=$((ITERATION + 1))
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

    echo "======================================== [$ITERATION] $TIMESTAMP" >> "$CEPH_STATUS_LOG"

    # 1. Ceph 集群状态
    {
        echo "=== Ceph Status ==="
        $CEPH_CMD -s 2>&1 || echo "错误: 无法获取 ceph status"
        echo ""
    } >> "$CEPH_STATUS_LOG" 2>&1

    # 2. OSD 性能统计
    {
        echo "======================================== [$ITERATION] $TIMESTAMP"
        echo "=== OSD Performance ==="
        $CEPH_CMD osd perf 2>&1 || echo "错误: 无法获取 osd perf"
        echo ""
    } >> "$CEPH_OSD_PERF_LOG" 2>&1

    # 3. OSD 磁盘使用情况
    {
        echo "======================================== [$ITERATION] $TIMESTAMP"
        echo "=== OSD Disk Usage ==="
        $CEPH_CMD osd df 2>&1 || echo "错误: 无法获取 osd df"
        echo ""
    } >> "$CEPH_OSD_DF_LOG" 2>&1

    # 4. Ceph 健康详情（每 3 次迭代采集一次，避免过于频繁）
    if [ $((ITERATION % 3)) -eq 0 ]; then
        {
            echo "======================================== [$ITERATION] $TIMESTAMP"
            echo "=== Ceph Health Detail ==="
            $CEPH_CMD health detail 2>&1 || echo "错误: 无法获取 health detail"
            echo ""
        } >> "$CEPH_HEALTH_LOG" 2>&1
    fi

    # 5. 慢操作检测
    {
        echo "======================================== [$ITERATION] $TIMESTAMP"
        SLOW_COUNT=$($CEPH_CMD -s 2>/dev/null | grep -oP '\d+(?= slow ops)' || echo "0")
        if [ "$SLOW_COUNT" -gt 0 ]; then
            echo "⚠ 检测到 $SLOW_COUNT 个慢操作"
            $CEPH_CMD status 2>&1 | grep -A 5 "slow ops" || true
        else
            echo "✓ 无慢操作"
        fi
        echo ""
    } >> "$SLOW_OPS_LOG" 2>&1

    # 6. 网络统计（每 2 次迭代采集一次）
    if [ $((ITERATION % 2)) -eq 0 ]; then
        {
            echo "======================================== [$ITERATION] $TIMESTAMP"
            echo "=== Network Statistics ==="
            if command -v netstat &> /dev/null; then
                netstat -s | grep -E "retransmit|error|drop" 2>&1 || echo "无网络统计"
            elif command -v ss &> /dev/null; then
                ss -s 2>&1 || echo "无网络统计"
            else
                echo "netstat/ss 不可用"
            fi
            echo ""
        } >> "$NETWORK_LOG" 2>&1
    fi

    # 7. dmesg 错误检测（每 3 次迭代采集一次）
    if [ $((ITERATION % 3)) -eq 0 ]; then
        {
            echo "======================================== [$ITERATION] $TIMESTAMP"
            echo "=== Kernel I/O Errors (last 50 lines) ==="
            sudo dmesg -T 2>&1 | grep -iE "error|fail|timeout|I/O|SCSI|nvme|ata" | tail -50 || echo "无 I/O 相关错误"
            echo ""
        } >> "$DMESG_LOG" 2>&1
    fi

    # 等待下一次采集
    sleep "$MONITOR_INTERVAL"
done &

# 保存后台循环的 PID
MONITOR_LOOP_PID=$!
echo "$MONITOR_LOOP_PID" > "$OUTPUT_DIR/monitor_loop.pid"

# 等待后台监控循环（会被 SIGTERM 信号中断）
wait "$MONITOR_LOOP_PID" 2>/dev/null || true

# 清理 iostat 进程
if [ -n "$IOSTAT_PID" ] && kill -0 "$IOSTAT_PID" 2>/dev/null; then
    kill -TERM "$IOSTAT_PID" 2>/dev/null || true
fi

echo "监控脚本已退出: $(date '+%Y-%m-%d %H:%M:%S')" | tee -a "$CEPH_STATUS_LOG"

