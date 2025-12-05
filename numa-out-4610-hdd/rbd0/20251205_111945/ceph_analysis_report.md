# Ceph 性能瓶颈分析报告

**分析时间**: 2025-12-05 11:27:19
**监控数据目录**: /home/ubuntu/numa-out-4610-hdd/rbd0/20251205_111945/ceph-monitoring

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
dm-13: 120.50%
dm-13: 90.10%
dm-3: 98.40%
dm-3: 99.70%
dm-5: 92.00%
dm-7: 90.50%
rbd0: 100.00%
rbd0: 100.10%
rbd0: 100.20%
rbd0: 98.20%
rbd0: 98.30%
rbd0: 98.40%
rbd0: 98.60%
rbd0: 98.70%
rbd0: 98.80%
rbd0: 98.90%
rbd0: 99.00%
rbd0: 99.01%
rbd0: 99.10%
rbd0: 99.20%
rbd0: 99.30%
rbd0: 99.40%
rbd0: 99.50%
rbd0: 99.60%
rbd0: 99.70%
rbd0: 99.80%
rbd0: 99.90%
sdc: 120.60%
sdc: 90.10%
sdd: 98.30%
sdd: 99.50%
sde: 92.00%
sdj: 90.50%
```

**建议**: 高利用率磁盘可能成为瓶颈，检查是否为慢盘或负载不均。

**⚠ 检测到高延迟磁盘（await > 50ms）：**
```
sdc: 55.00 ms
sdd: 57.50 ms
sdd: 60.75 ms
sdd: 78.50 ms
sde: 57.40 ms
sde: 79.33 ms
sde: 89.33 ms
sdg: 64.33 ms
sdg: 65.00 ms
sdg: 76.33 ms
sdj: 76.00 ms
sdj: 80.33 ms
```

---

### 网络问题分析

⚠ **检测到网络问题**

**重传统计：**
    1722 segments retransmitted
    7 fast retransmits
    1722 segments retransmitted

**错误/丢包：**
```
    29 dropped because of missing route
    0 packet receive errors
    0 receive buffer errors
    0 send buffer errors
    29 dropped because of missing route
```

**建议**: 网络重传或丢包可能导致延迟抖动，检查交换机/网卡配置。

---

### 内核 I/O 错误分析

⚠ **检测到 147 条内核 I/O 相关错误**

**最近错误样本（最后 10 条）：**
```
[Thu Dec  4 19:38:15 2025] ACPI Error: Aborting method \_SB.PMI0._GHL due to previous error (AE_NOT_EXIST) (20230628/psparse-529)
[Thu Dec  4 19:38:15 2025] ACPI Error: Aborting method \_SB.PMI0._PMC due to previous error (AE_NOT_EXIST) (20230628/psparse-529)
[Thu Dec  4 19:38:15 2025] ACPI: \_SB_.PMI0: _PMC evaluation failed: AE_NOT_EXIST
=== Kernel I/O Errors (last 50 lines) ===
[Thu Dec  4 19:38:15 2025] power_meter ACPI000D:00: Waiting for ACPI IPMI timeout
[Thu Dec  4 19:38:15 2025] ACPI Error: AE_NOT_EXIST, Returned by Handler for [IPMI] (20230628/evregion-301)
[Thu Dec  4 19:38:15 2025] ACPI Error: Region IPMI (ID=7) has no handler (20230628/exfldio-261)
[Thu Dec  4 19:38:15 2025] ACPI Error: Aborting method \_SB.PMI0._GHL due to previous error (AE_NOT_EXIST) (20230628/psparse-529)
[Thu Dec  4 19:38:15 2025] ACPI Error: Aborting method \_SB.PMI0._PMC due to previous error (AE_NOT_EXIST) (20230628/psparse-529)
[Thu Dec  4 19:38:15 2025] ACPI: \_SB_.PMI0: _PMC evaluation failed: AE_NOT_EXIST
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

