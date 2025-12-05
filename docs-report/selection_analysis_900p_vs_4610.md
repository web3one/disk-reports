# Ceph OSD 混合存储选型分析报告：Intel Optane vs. Intel 4610

**日期**: 2025-12-05
**项目背景**: 单节点 12 块机械硬盘 (HDD)，需选择一块 NVMe 设备作为 WAL/DB 加速盘。
**候选硬件**:
1.  **Intel Optane 900P (280GB)**: 3D XPoint 介质，极致低延迟，高耐用。
2.  **Intel SSD DC P4610 (1.6TB)**: 3D NAND TLC 介质，大容量，标准企业级性能。

---

## 1. 核心决策分析

在 **12 个 OSD 共享一块盘** 的高密度场景下，**容量（Capacity）** 的重要性优先级高于 **极限性能（Peak Performance）**。

### 1.1 关键计算：单 OSD 可用空间

| 方案 | 总容量 | OSD 数量 | **单 OSD 分配空间 (WAL + DB)** | 空间评价 |
| :--- | :--- | :--- | :--- | :--- |
| **Optane 900P** | 280 GB | 12 | **~23 GB** | **极度紧张 (高风险)** |
| **Intel 4610** | 1.6 TB | 12 | **~133 GB** | **充裕 (安全)** |

### 1.2 风险评估：“DB Spillover” (溢出) 问题
Ceph BlueStore 的性能极其依赖于 RocksDB 是否完全驻留在高速设备上。
*   **Optane 方案 (23GB/OSD)**:
    *   通常分配：WAL (2GB) + DB (21GB)。
    *   **风险**: 随着数据量增长或碎片化，RocksDB 的 SST 文件很容易超过 21GB。一旦发生 **Spillover (溢出)**，RocksDB 数据被迫写入慢速 HDD，OSD 性能将出现 **断崖式下跌**，甚至不如纯 HDD。
*   **4610 方案 (133GB/OSD)**:
    *   通常分配：WAL (2GB) + DB (60GB - 100GB)。
    *   **优势**: 100GB 的 DB 空间足以支撑 HDD 存储数百万个对象而不发生溢出，性能输出非常稳定。

---

## 2. 性能与耐用性对比

| 指标 | Intel Optane 900P | Intel SSD 4610 | 实际影响分析 |
| :--- | :--- | :--- | :--- |
| **写入延迟 (WAL)** | **~10µs** | ~50µs | Optane 极快，但在 HDD 后端场景下，4610 已足够快，不会成为瓶颈。 |
| **IOPS (实测)** | **30k** | 25k | 20% 的提升很可观，但前提是 DB 不溢出。 |
| **耐用性 (DWPD)** | **10 DWPD** | 3 DWPD | 作为 WAL，Optane 寿命更长。但 1.6TB 的 4610 总写入量巨大 (PB级)，足以支撑生命周期。 |

---

## 3. 之前的测试回顾

根据目录 `docs-report/` 下的报告：
1.  **`numa-900p-hdd`**: 表现优异，IOPS 达到 30k，延迟极低。
2.  **`numa-out-4610-hdd`**: 表现稍逊 (25k IOPS)，且存在 NUMA Mismatch。

**修正观点**:
虽然 Optane 测试数据更好，但那是 **"全新空盘"** 状态下的测试。随着集群长期运行，数据填满，280GB 的 Optane 面临的空间压力将是致命的。而 4610 如果解决了 NUMA 问题，其性能对于 HDD 来说是完全过剩的。

---

## 4. 最终选型建议

### 方案 A：稳健生产型 (强烈推荐)
**选择硬件**: **Intel SSD 4610 (1.6TB)**
*   **配置策略**: 每个 OSD 分配 2GB WAL + 60GB DB (预留空间给 SSD 磨损均衡)。
* 通用生产环境、海量小文件（S3/RGW）、对象数量多
*   **理由**:
    1.  **安全第一**: 彻底消除 DB 溢出到 HDD 的风险。
    2.  **运维轻松**: 不需要时刻盯着元数据使用量。
    3.  **性能足够**: 修正 NUMA 亲和性后，4610 完全能喂饱 12 块 HDD。

### 方案 B：极限性能型 (仅限特定场景)
**选择硬件**: **Intel Optane 900P (280GB)**
*   **适用场景**: 纯 RBD 块存储、大文件存储（对象数量少，元数据少）、或者作为特定高性能池。
*   **配置策略**: 必须精打细算，监控 RocksDB 大小。
*   **理由**: 追求极致的写入低延迟。

### 方案 C：终极形态 (如果插槽允许)
**选择硬件**: **同时使用 Optane + 4610**
*   **配置策略**:
    *   **Optane 900P**: 仅做 WAL (Write Ahead Log)。每个 OSD 分 2GB，共占用 24GB，性能无敌。
    *   **Intel 4610**: 仅做 DB (RocksDB)。每个 OSD 分 100GB，容量无忧。
*   **评价**: 这是土豪且完美的方案，结合了 Optane 的速度和 4610 的容量。

---

## 5. 实施步骤建议 (基于方案 A)

如果您决定采用 **Intel 4610**，请执行以下优化以确保性能最大化：

1.  **物理插槽调整**: 确保 4610 插在 CPU 0 对应的 PCIe 插槽（或者确认 OSD 进程绑定到 SSD 所在的 NUMA 节点）。
2.  **LVM 分区**:
    ```bash
    # 假设 nvme0n1 是 4610
    # 为每个 HDD 创建逻辑卷 (示例)
    lvcreate -L 60G -n db-osd-0 vg_nvme
    lvcreate -L 2G -n wal-osd-0 vg_nvme
    ```
3.  **部署命令**:
    ```bash
    ceph-volume lvm create --bluestore --data /dev/sdX --block.db /dev/vg_nvme/db-osd-X --block.wal /dev/vg_nvme/wal-osd-X
    ```
