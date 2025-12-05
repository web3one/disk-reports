# Ceph 性能瓶颈分析报告

**分析时间**: 2025-12-03 11:38:57
**监控数据目录**: /home/ubuntu/intel-900p-hdd/rbd0/20251203_113538/ceph-monitoring

---

### OSD 延迟分析

| 指标 | 平均值 (ms) | 峰值 (ms) | 状态 |
|------|------------|----------|------|
| OSD Apply Latency | 0.00 | 0.00 | ✓ 正常 |
| OSD Commit Latency | 0.00 | 0.00 | ✓ 正常 |

---

### 慢操作分析

| 指标 | 值 | 状态 |
|------|-------|------|
| 慢操作出现次数 | 0 | ✓ 正常 |
| 单次最大慢操作数 | 0 | - |

---

### 磁盘 I/O 瓶颈分析

**⚠ 检测到高利用率磁盘（util > 90%）：**
```
rbd0: 100.00%
rbd0: 100.10%
rbd0: 100.33%
rbd0: 100.41%
rbd0: 100.50%
rbd0: 90.20%
rbd0: 90.50%
rbd0: 91.10%
rbd0: 91.20%
rbd0: 91.40%
rbd0: 91.60%
rbd0: 92.66%
rbd0: 92.90%
rbd0: 93.20%
rbd0: 94.40%
rbd0: 95.10%
rbd0: 95.30%
rbd0: 96.20%
rbd0: 96.37%
rbd0: 96.70%
rbd0: 97.00%
rbd0: 97.90%
rbd0: 98.30%
rbd0: 98.80%
rbd0: 99.20%
rbd0: 99.22%
rbd0: 99.30%
rbd0: 99.49%
rbd0: 99.79%
rbd0: 99.80%
rbd0: 99.90%
sdm: 90.10%
sdm: 90.20%
sdm: 90.30%
sdm: 90.40%
sdm: 90.50%
sdm: 90.53%
sdm: 90.57%
sdm: 90.60%
sdm: 90.70%
sdm: 90.80%
sdm: 90.90%
sdm: 91.00%
sdm: 91.20%
sdm: 91.40%
sdm: 91.50%
sdm: 91.60%
sdm: 91.70%
sdm: 91.76%
sdm: 91.80%
sdm: 91.90%
sdm: 92.10%
sdm: 92.17%
sdm: 92.20%
sdm: 92.40%
sdm: 92.50%
sdm: 92.59%
sdm: 92.60%
sdm: 92.70%
sdm: 92.80%
sdm: 92.90%
sdm: 93.00%
sdm: 93.12%
sdm: 93.20%
sdm: 93.50%
sdm: 93.78%
sdm: 93.80%
sdm: 93.90%
sdm: 94.20%
sdm: 94.30%
sdm: 94.40%
sdm: 94.50%
sdm: 94.60%
sdm: 94.64%
sdm: 94.78%
sdm: 94.86%
sdm: 94.90%
sdm: 94.93%
sdm: 95.00%
sdm: 95.40%
sdm: 95.45%
sdm: 95.60%
sdm: 95.70%
sdm: 95.80%
sdm: 95.83%
sdm: 95.90%
sdm: 96.00%
sdm: 96.20%
sdm: 96.30%
sdm: 96.35%
sdm: 96.50%
sdm: 96.60%
sdm: 96.73%
sdm: 96.93%
sdm: 97.00%
sdm: 97.10%
sdm: 97.20%
sdm: 97.30%
sdm: 97.40%
sdm: 97.79%
sdm: 97.91%
sdm: 98.00%
sdm: 98.02%
sdm: 98.10%
sdm: 98.20%
sdm: 98.29%
sdm: 98.31%
sdm: 98.40%
sdm: 98.50%
sdm: 98.90%
sdm: 98.93%
sdm: 99.51%
sdm: 99.67%
sdm: 99.70%
```

**建议**: 高利用率磁盘可能成为瓶颈，检查是否为慢盘或负载不均。

**⚠ 检测到高延迟磁盘（await > 50ms）：**
```
sdk: 186.67 ms
sdl: 90.60 ms
```

---

### 网络问题分析

⚠ **检测到网络问题**

**重传统计：**
    44401 segments retransmitted
    30517 fast retransmits
    66 retransmits in slow start

**错误/丢包：**
```
    20 outgoing packets dropped
    5 dropped because of missing route
    0 packet receive errors
    0 receive buffer errors
    0 send buffer errors
```

**建议**: 网络重传或丢包可能导致延迟抖动，检查交换机/网卡配置。

---

### 内核 I/O 错误分析

⚠ **检测到 13 条内核 I/O 相关错误**

**最近错误样本（最后 10 条）：**
```
[Mon Dec  1 11:27:57 2025] ACPI Error: Region IPMI (ID=7) has no handler (20230628/exfldio-261)
[Mon Dec  1 11:27:57 2025] ACPI Error: Aborting method \_SB.PMI0._GHL due to previous error (AE_NOT_EXIST) (20230628/psparse-529)
[Mon Dec  1 11:27:57 2025] ACPI Error: Aborting method \_SB.PMI0._PMC due to previous error (AE_NOT_EXIST) (20230628/psparse-529)
[Mon Dec  1 11:27:57 2025] ACPI: \_SB_.PMI0: _PMC evaluation failed: AE_NOT_EXIST
[Tue Dec  2 14:07:17 2025] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[Tue Dec  2 14:07:17 2025] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[Tue Dec  2 14:07:17 2025] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[Tue Dec  2 14:09:20 2025] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[Tue Dec  2 14:09:20 2025] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[Tue Dec  2 14:09:20 2025] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
```

**建议**: 内核 I/O 错误可能表明硬件故障，检查磁盘 SMART 状态和系统日志。

---

### OSD 磁盘空间分析

✓ 所有 OSD 磁盘使用率正常（< 80%）

---

## 瓶颈诊断总结

### 常见瓶颈类型及处理建议

1. **OSD 延迟过高**
   - **现象**: Apply/Commit Latency > 100ms
   - **可能原因**: 慢盘、磁盘故障、OSD 过载
   - **处理建议**: 检查慢盘（smartctl）、平衡 OSD 负载、更换故障盘

2. **频繁慢操作**
   - **现象**: Slow ops 频繁出现
   - **可能原因**: 网络延迟、OSD 繁忙、PG 不均衡
   - **处理建议**: 检查网络、优化 CRUSH map、调整 PG 数量

3. **磁盘 I/O 瓶颈**
   - **现象**: 磁盘 util > 90%，await > 50ms
   - **可能原因**: 单盘 IOPS/带宽达到上限
   - **处理建议**: 负载均衡、增加缓存盘（NVMe metadata）、升级硬件

4. **网络抖动**
   - **现象**: 高重传率、丢包
   - **可能原因**: 网络拥塞、交换机故障、MTU 不匹配
   - **处理建议**: 检查交换机端口、启用 Jumbo Frame、优化 QoS

5. **内核 I/O 错误**
   - **现象**: dmesg 出现 I/O error/timeout
   - **可能原因**: 硬件故障（磁盘、HBA、线缆）
   - **处理建议**: 立即更换故障硬件，避免数据丢失

