# Ceph WAL/DB 性能对比分析报告：Intel Optane 900P vs. Intel 4610

## 1. 概述
本报告基于 2025 年 12 月 5 日采集的测试数据，对两组 Ceph 性能测试结果进行了详细对比。测试旨在评估不同型号的 SSD（Intel Optane 900P 与 Intel 4610）作为 Ceph OSD 的 WAL/DB 设备时的性能表现，并结合 NUMA 架构的影响进行分析。

## 2. 测试配置对比

| 配置项 | **配置 A (`numa-900p-hdd`)** | **配置 B (`numa-out-4610-hdd`)** |
| :--- | :--- | :--- |
| **WAL/DB 设备** | **Intel Optane 900P** | **Intel SSD 4610** |
| **存储后端** | HDD (Bluestore) | HDD (Bluestore) |
| **NUMA 状态** | 优化 (亲和性良好) | **Mismatch (跨 NUMA 访问)** |
| **数据来源** | `numa-900p-hdd/rbd0/20251205_095936/` | `numa-out-4610-hdd/rbd0/20251205_113237/` |

## 3. 核心性能指标对比

### 3.1 IOPS (每秒输入/输出操作数)
*   **Intel Optane 900P**: 峰值性能达到约 **30,000 IOPS**。
*   **Intel SSD 4610**: 峰值性能约为 **25,000 IOPS**。
*   **分析**: Optane 900P 带来了约 **20%** 的 IOPS 提升。这主要得益于 Optane 介质在小块随机写入上的巨大优势，能更快地处理 RocksDB 的元数据和 WAL 写入。

### 3.2 Latency (延迟)
*   **Commit Latency (提交延迟)**:
    *   **900P**: 稳定保持在 **2ms** 左右。
    *   **4610**: 波动较大，平均在 **3ms - 4ms** 之间。
*   **分析**: 4610 组的延迟比 900P 高出 **50% - 100%**。除了介质本身的差异外，`numa-out` 配置导致的跨 CPU 节点内存访问和 PCIe 通信也是导致延迟增加的重要原因。

## 4. 深度分析

### 4.1 介质技术差异
Intel Optane (基于 3D XPoint 技术) 相比传统的 NAND Flash (如 Intel 4610)，在低队列深度下的随机读写性能上有本质的区别。Ceph 的 WAL 和 DB 负载通常是密集的、对延迟极度敏感的小块写入，这正是 Optane 的强项。

### 4.2 NUMA 效应
配置 B 被标记为 `numa-out`，表明 OSD 进程运行的 CPU 核心与 NVMe 硬件所在的 NUMA 节点不一致。
*   **跨节点开销**: CPU 需要通过 QPI/UPI 总线访问另一颗 CPU 管理的内存或 PCIe 设备，增加了物理传输链路的长度和延迟。
*   **资源争抢**: 在高并发场景下，跨 NUMA 访问会导致总线带宽争抢，进一步恶化尾部延迟（Tail Latency）。

## 5. 结论与建议

1.  **硬件选型建议**: 对于追求极致性能的 Ceph 集群（特别是使用 HDD 作为数据盘时），建议使用 **Intel Optane** 或同级别的 SCM (Storage Class Memory) 设备作为 WAL/DB 分区。它能显著消除 HDD 的写入瓶颈。
2.  **系统调优建议**: **NUMA 亲和性优化是必须项**。
    *   务必确保 OSD 进程绑定在与 NVMe/SSD 物理插槽对应的同一 NUMA 节点上。
    *   检查网卡中断（IRQ）是否也绑定在正确的 NUMA 节点，以避免网络层面的跨节点延迟。
