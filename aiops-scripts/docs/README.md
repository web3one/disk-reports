# Ceph FIO 压测与性能分析工具

## 概述

这是一套用于 Ceph 存储集群性能压测和瓶颈分析的工具集，包含：

1. **FIO 压测脚本** (`local_fio.sh`) - 在目标设备上执行 FIO 基准测试
2. **Ceph 性能监控** (`ceph_perf_monitor.sh`) - 压测期间并行监控 Ceph 集群性能
3. **性能分析工具** (`analyze_ceph_perf.sh`) - 自动分析监控数据并识别瓶颈
4. **远程执行脚本** (`run_fio.sh`) - 自动化部署和执行整个测试流程

## 核心功能特性

### ✨ 增强的延迟指标（已全部换算为 ms）

报告中的所有延迟指标已从微秒（us）转换为毫秒（ms），更符合生产环境评估习惯：

| 指标 | 说明 | 生产环境建议阈值 |
|------|------|----------------|
| **Avg Latency (ms)** | 平均延迟，反映整体流畅度 | 越低越好 |
| **P99 Latency (ms)** | 99% 请求的响应时间 | 越低越好 |
| **P99.99 Latency (ms)** | 99.99% 请求的响应时间<br/>**生产环境生死线** | HDD 混合池: < 500ms<br/>全闪池: < 10ms |
| **Latency Stdev (ms)** | 延迟标准差，衡量抖动程度 | 越小越稳定<br/>标准差过大表明存在坏盘或网络抖动 |

### 🔍 Ceph 性能监控与瓶颈分析

在 FIO 压测期间，自动并行采集以下指标：

- **Ceph 集群状态** (`ceph -s`) - 每 5 秒
- **OSD 性能统计** (`ceph osd perf`) - Apply/Commit Latency
- **OSD 磁盘使用** (`ceph osd df`) - 磁盘空间占用
- **慢操作检测** - 实时监控 slow ops
- **存储设备 I/O** (`iostat`) - 磁盘利用率、await、iops
- **网络统计** - 重传率、丢包率
- **内核错误日志** (`dmesg`) - I/O 相关错误

分析脚本会自动识别以下瓶颈：

1. ⚠️ **OSD 延迟过高** (Apply/Commit Latency > 100ms)
2. ⚠️ **频繁慢操作** (Slow ops count > 10)
3. ⚠️ **磁盘 I/O 瓶颈** (util > 90%, await > 50ms)
4. ⚠️ **网络抖动** (高重传率、丢包)
5. ⚠️ **内核 I/O 错误** (dmesg 中的硬件故障信号)


## 快速开始

### 1. 本地执行（在存储节点上）

```bash
cd aiops-deploy/ceph-fio

# 对 RBD 设备进行压测
sudo ./local_fio.sh /dev/rbd0

# 对本地 NVMe 设备进行压测
sudo ./local_fio.sh /dev/nvme1n1

# 指定自定义输出目录
sudo ./local_fio.sh /dev/rbd0 /home/ubuntu/my-reports/test1
```

### 2. 远程执行（推荐）

```bash
cd aiops-deploy/ceph-fio

# 配置远程主机（编辑 run_fio.sh 中的变量）
# REMOTE_HOST="dc1-stor40"
# REMOTE_USER="ubuntu"

# 执行压测
./run_fio.sh /dev/rbd0

# 结果会自动同步到本地 ../../../disks-report/ 目录
```

## 输出文件结构

压测完成后，会在 `disks-report/<设备名>/<时间戳>/` 目录下生成以下文件：

```
disks-report/rbd0/20251202_143025/
├── fio-results_20251202_143025.json          # FIO 原始 JSON 数据
├── fio_benchmark_report_20251202_143025.md   # FIO 性能报告（ms 单位）
├── fio-console_20251202_143025.log           # FIO 执行日志
├── ceph_analysis_report.md                    # Ceph 性能瓶颈分析报告
└── ceph-monitoring/                           # Ceph 监控原始数据
    ├── ceph_status.log
    ├── ceph_osd_perf.log
    ├── ceph_osd_df.log
    ├── iostat.log
    ├── slow_ops.log
    ├── network_stats.log
    └── dmesg_errors.log
```

## 查看报告

### FIO 性能报告

```bash
cat disks-report/rbd0/20251202_143025/fio_benchmark_report_20251202_143025.md
```

示例输出：

```markdown
# FIO 压测报告

## 1. 随机读 (RND-READ-4K)

| 作业名 | IOPS | 吞吐量 (MB/s) | 平均延迟 (ms) | P99 延迟 (ms) | P99.99 延迟 (ms) | 延迟标准差 (ms) |
|-------|------|-------------|-------------|-------------|----------------|---------------|
| RND-READ-4K-2-256 | 25,430 | 99.34 | 20.12 | 45.67 | 125.50 | 8.34 |

## 指标说明

- **平均延迟 (Avg Latency)**: 平均响应时间，反映整体流畅度（越低越好）
- **P99.99 延迟**: 99.99% 请求的响应时间，生产环境生死线
  - HDD 混合池建议 < 500ms
  - 全闪池建议 < 10ms
- **延迟标准差 (Latency Stdev)**: 延迟波动程度，越小越稳定
  - 如果标准差很大，可能存在坏盘或网络抖动问题
```

### Ceph 性能分析报告

```bash
cat disks-report/rbd0/20251202_143025/ceph_analysis_report.md
```

示例输出：

```markdown
# Ceph 性能瓶颈分析报告

## OSD 延迟分析

| 指标 | 平均值 (ms) | 峰值 (ms) | 状态 |
|------|------------|----------|------|
| OSD Apply Latency | 12.34 | 85.67 | ✓ 正常 |
| OSD Commit Latency | 8.90 | 62.45 | ✓ 正常 |

## 慢操作分析

| 指标 | 值 | 状态 |
|------|-------|------|
| 慢操作出现次数 | 3 | ⚠ 偶现慢操作 |
| 单次最大慢操作数 | 2 | - |

## 磁盘 I/O 瓶颈分析

⚠ 检测到高利用率磁盘（util > 90%）：
```
sdb: 95.3%
sdc: 92.1%
```

**建议**: 高利用率磁盘可能成为瓶颈，检查是否为慢盘或负载不均。
```

## 配置说明

### FIO 测试参数（test0.fio）

- **ioengine**: libaio (Linux 异步 I/O)
- **direct**: 1 (直接 I/O，绕过缓存)
- **runtime**: 15 秒/作业
- **ramp_time**: 3 秒预热（不计入结果）
- **size**: 1GB/作业

### 测试场景

#### 随机读/写 (RND-*)
- BlockSize: 4KB
- 模式: 随机读写
- 并发配置: 2 jobs × 256 iodepth

#### 顺序读/写 (SEQ-*)
- BlockSize: 1MB
- 模式: 顺序读写
- 不同并发度组合

### 监控采集频率

- Ceph 状态/OSD 性能: 5 秒
- iostat 磁盘 I/O: 1 秒
- 网络统计: 10 秒
- dmesg 错误: 15 秒

可通过修改 `ceph_perf_monitor.sh` 中的 `MONITOR_INTERVAL` 变量调整。

## 故障排查

### 1. Ceph 命令无权限

**问题**: 监控脚本报错 "无法执行 ceph 命令"

**解决方案**:
```bash
# 方案 A: 为 ubuntu 用户配置 ceph 权限
sudo cp /etc/ceph/ceph.client.admin.keyring /home/ubuntu/.ceph/
sudo chown ubuntu:ubuntu /home/ubuntu/.ceph/ceph.client.admin.keyring

# 方案 B: 脚本会自动尝试使用 sudo
# 确保 ubuntu 用户有 sudo 权限且不需要密码
```

### 2. FIO 压测失败

查看详细日志：
```bash
cat disks-report/rbd0/<时间戳>/fio-console_*.log
```

常见原因：
- 磁盘空间不足
- 设备不存在或无权限
- 文件句柄限制过低（脚本会自动提升到 65536）

### 3. 监控数据不完整

**问题**: `ceph-monitoring/` 目录下某些日志文件为空

**可能原因**:
- Ceph 命令权限不足（见问题 1）
- 工具未安装（iostat, netstat, dmesg）

**解决方案**:
```bash
# 安装缺失工具
sudo apt-get install sysstat net-tools

# 检查监控脚本是否正常运行
ps aux | grep ceph_perf_monitor
```

### 4. 设备路径解析警告

**警告信息**: "⚠ 警告: 设备 /dev/nvme2n1 无法解析为稳定路径"

**说明**: 脚本无法找到对应的 `/dev/disk/by-id` 路径，将继续使用原路径。重启后可能改变。

**解决方案**:
```bash
# 手动查找稳定路径
ls -l /dev/disk/by-id/ | grep nvme2n1

# 直接使用稳定路径
sudo ./local_fio.sh /dev/disk/by-id/nvme-Samsung_SSD_970_EVO_Plus_1TB_S4EWNF0M123456
```

## 性能调优建议

### 根据 P99.99 Latency 评估

| 场景 | P99.99 阈值 | 建议 |
|------|-----------|------|
| 全闪池 | < 10ms | ✓ 生产可用 |
| 全闪池 | 10-50ms | ⚠ 可能存在慢盘或网络问题 |
| 全闪池 | > 50ms | ✗ 不适合生产，需排查瓶颈 |
| HDD 混合池 | < 200ms | ✓ 优秀 |
| HDD 混合池 | 200-500ms | ⚠ 可接受，建议优化 |
| HDD 混合池 | > 500ms | ✗ 需排查慢盘或配置问题 |

### 根据 Latency Stdev 评估抖动

| Stdev / Avg Latency 比值 | 评估 | 建议 |
|------------------------|------|------|
| < 0.3 | ✓ 稳定 | 无需优化 |
| 0.3 - 0.5 | ⚠ 轻微抖动 | 检查慢盘和网络 |
| > 0.5 | ✗ 严重抖动 | 立即排查坏盘/网络问题 |

### 常见瓶颈及处理

参考 `ceph_analysis_report.md` 中的"瓶颈诊断总结"章节，包含：

1. OSD 延迟过高
2. 频繁慢操作
3. 磁盘 I/O 瓶颈
4. 网络抖动
5. 内核 I/O 错误

每种瓶颈都包含现象描述、可能原因和处理建议。

## 进阶用法

### 自定义 FIO 测试场景

编辑 `test0.fio` 文件，调整参数：

```ini
[global]
runtime=30        # 增加运行时间到 30 秒
ramp_time=5       # 预热 5 秒

[RND-READ-4K-4-512]   # 更高并发：4 jobs × 512 iodepth
bs=4K
rw=randread
numjobs=4
iodepth=512
stonewall
```

### 仅运行监控（不执行 FIO）

```bash
# 手动启动监控
./ceph_perf_monitor.sh /tmp/my-monitoring 5 &
MONITOR_PID=$!

# 执行你的自定义测试
# ...

# 停止监控
kill -TERM $MONITOR_PID

# 分析结果
./analyze_ceph_perf.sh /tmp/my-monitoring /tmp/my-report.md
```

### 批量测试多个设备

```bash
#!/bin/bash
for dev in /dev/rbd{0..3}; do
    echo "测试 $dev ..."
    sudo ./local_fio.sh "$dev"
    sleep 10
done
```

## 相关文档

- [FIO 官方文档](https://fio.readthedocs.io/)
- [Ceph 性能调优指南](https://docs.ceph.com/en/latest/rados/configuration/bluestore-config-ref/)
- [Ceph 故障排查](https://docs.ceph.com/en/latest/rados/troubleshooting/)

## 许可证

本工具集遵循主项目的许可证。

