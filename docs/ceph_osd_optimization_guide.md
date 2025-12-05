# Ceph OSD配置深度优化指南

**创建日期**: 2025-12-03
**适用场景**: Rook-Ceph部署在Kubernetes环境
**优化目标**: 提升Ceph OSD性能，降低延迟

---

## 一、OSD线程与并发配置

### 1.1 OSD操作线程配置

```yaml
# 在rook-ceph-cluster.yaml的spec.cephClusterSpec.config中添加
config:
  # 每个shard的操作线程数
  # 推荐值: CPU核心数的1/4到1/2
  osd_op_num_threads_per_shard: "4"

  # OSD分片数
  # 推荐值: 8-16，根据CPU核心数调整
  osd_op_num_shards: "8"

  # OSD客户端操作线程数
  # 推荐值: 4-8
  osd_op_num_threads_per_shard_hdd: "4"
  osd_op_num_threads_per_shard_ssd: "4"
```

**硬件建议**:
- **HDD**: `osd_op_num_threads_per_shard_hdd: "2"`
- **SSD/SATA**: `osd_op_num_threads_per_shard_ssd: "4"`
- **NVMe/Optane**: `osd_op_num_threads_per_shard_ssd: "8"`

### 1.2 OSD恢复与回填限制

```yaml
config:
  # 限制恢复速度，避免影响正常IO
  # 默认: 100 (MB/s)
  osd_max_backfills: "1"
  osd_recovery_max_active: "3"
  osd_recovery_op_priority: "3"
  osd_recovery_max_single_start: "1"

  # 限制回填速度
  osd_backfill_scan_min: "64"
  osd_backfill_scan_max: "512"
  osd_backfill_full_ratio: "0.85"
  osd_backfill_retry_interval: "10"
```

### 1.3 OSD客户端并发

```yaml
config:
  # 客户端操作优先级
  osd_client_op_priority: "63"
  osd_client_message_size_cap: "1073741824"  # 1GB
  osd_client_message_cap: "1000"
```

---

## 二、BlueStore深度优化

### 2.1 分配单元大小

```yaml
config:
  # BlueStore最小分配单元
  # HDD推荐: 65536 (64KB)
  # SSD推荐: 16384 (16KB)
  # NVMe/Optane推荐: 4096 (4KB)
  bluestore_min_alloc_size: "4096"

  # BlueStore最小分配大小HDD
  bluestore_min_alloc_size_hdd: "65536"

  # BlueStore最小分配大小SSD
  bluestore_min_alloc_size_ssd: "4096"
```

### 2.2 缓存配置

```yaml
config:
  # BlueStore缓存大小
  # 推荐值: 内存的10-20%
  # 对于256GB内存: 3221225472 (3GB)
  bluestore_cache_size: "3221225472"

  # HDD专用缓存
  bluestore_cache_size_hdd: "1073741824"  # 1GB

  # SSD专用缓存
  bluestore_cache_size_ssd: "3221225472"  # 3GB

  # 对象大小
  bluestore_cache_trim_interval: "30"
  bluestore_cache_trim_max_skip_pinned: "1000"
```

### 2.3 预读和合并设置

```yaml
config:
  # 禁用预读（随机IO场景）
  bluestore_no_trunc: "false"
  bluestore_prefer_deferred_size: "32768"

  # 合并连续写
  bluestore_max_blob_size: "524288"  # 512KB
  bluestore_compression_min_blob_size: "131072"  # 128KB
  bluestore_compression_max_blob_size: "524288"  # 512KB
```

### 2.4 异步IO设置

```yaml
config:
  # Linux AIO设置
  bluestore_aio: "true"
  bluestore_aio_max: "65536"
  bluestore_aio_poll_max: "256"

  # SPDK/DPDK（如果使用NVMe）
  bluestore_spdk: "false"  # 如果要使用SPDK，将此设置为true
```

---

## 三、磁盘与IO调度优化

### 3.1 调度器设置

对于不同的磁盘类型，使用不同的调度器：

**Optane/NVMe SSD**: 使用`none`或`noop`
**SATA SSD**: 使用`noop`或`mq-deadline`
**HDD**: 使用`mq-deadline`或`bfq`

```bash
#!/bin/bash
# 优化磁盘调度器脚本
# 放入Kubernetes的initContainer中执行

devices=("sdm" "sdn" "nvme0n1" "nvme1n1")
disk_type="nvme"  # options: nvme, sata, hdd

for dev in "${devices[@]}"; do
    scheduler_path="/sys/block/${dev}/queue/scheduler"

    if [ -f "$scheduler_path" ]; then
        case $disk_type in
            nvme)
                echo "none" > $scheduler_path
                echo 256 > "/sys/block/${dev}/queue/nr_requests"
                echo 0 > "/sys/block/${dev}/queue/add_random"
                echo 0 > "/sys/block/${dev}/queue/rotational"
                ;;
            sata)
                echo "mq-deadline" > $scheduler_path
                echo 128 > "/sys/block/${dev}/queue/nr_requests"
                ;;
            hdd)
                echo "mq-deadline" > $scheduler_path
                echo 64 > "/sys/block/${dev}/queue/nr_requests"
                ;;
        esac
    fi
done
```

### 3.2 文件描述符限制

```yaml
# 在rook-ceph-operator.yaml或node配置中
spec:
  cephClusterSpec:
    cephConfig:
      global:
        max_open_files: "131072"  # 128K
```

### 3.3 OSD内存目标

```yaml
config:
  # OSD内存目标，防止OOM
  # 推荐值：内存的50-70%
  osd_memory_target: "17179869184"  # 16GB

  # 自动调整内存
  osd_memory_base: "8589934592"  # 8GB
  osd_memory_expected_fragmentation: "0.15"
  osd_memory_cache_min: "1073741824"  # 1GB
  osd_memory_cache_resize_interval: "30"
```

---

## 四、网络协议优化

### 4.1 Messenger v2配置

```yaml
config:
  # 启用v2协议（msgr2）
  ms_bind_msgr2: "true"

  # TCP参数
  ms_async_op_threads: "4"
  ms_async_max_backlog: "128"

  # 连接超时
  ms_connection_idle_timeout: "900"
  ms_connection_ready_timeout: "10"

  # 发送/接收缓冲区
  ms_crc_data: "false"  # 如果网络可靠，可以禁用CRC校验提升性能
  ms_crc_header: "false"
```

### 4.2 TCP优化参数

```bash
# 在Kubernetes node上配置
# 添加到 /etc/sysctl.conf

# 增加TCP缓冲区
net.core.rmem_max = 134217728
net.core.wmem_max = 134217728
net.ipv4.tcp_rmem = 4096 87380 134217728
net.ipv4.tcp_wmem = 4096 65536 134217728

# 减少重传次数
net.ipv4.tcp_retries2 = 5
net.ipv4.tcp_syn_retries = 3

# 启用快速打开
net.ipv4.tcp_fastopen = 3

# 调整keepalive
net.ipv4.tcp_keepalive_time = 600
net.ipv4.tcp_keepalive_intvl = 60
net.ipv4.tcp_keepalive_probes = 3

# 启用拥塞控制
net.ipv4.tcp_congestion_control = bbr
```

---

## 五、Rook-Ceph特定配置

### 5.1 存储节点选择

```yaml
# 在rook-ceph-cluster.yaml中
spec:
  storage:
    useAllNodes: false
    useAllDevices: false
    nodes:
    - name: "dc1-stor40"
      devices:
      - name: "nvme0n1"
        config:
          osdsPerDevice: "1"
          metadataDevice: "/dev/sdm"  # 指定元数据盘
    - name: "dc1-stor41"
      devices:
      - name: "nvme0n1"
    - name: "dc1-stor42"
      devices:
      - name: "nvme0n1"
```

### 5.2 分离DB/WAL设备

```yaml
# 使用单独的NVMe或Optane设备作为DB/WAL
storage:
  nodes:
  - name: "dc1-stor40"
    devices:
    - name: "sda"  # 数据盘
      config:
        databaseSizeMB: "204800"  # DB大小
        storeType: bluestore
        osdsPerDevice: "1"
    - name: "/dev/sdm"  # NVMe/Optane作为元数据盘
      config:
        deviceClass: nvme
        metadataOnly: true
```

### 5.3 Pod资源限制

```yaml
# 为OSD pod分配足够资源
spec:
  resources:
    osd:
      limits:
        cpu: "8"
        memory: "32Gi"
      requests:
        cpu: "4"
        memory: "16Gi"
```

---

## 六、性能监控配置

### 6.1 启用详细性能计数器

```yaml
config:
  # 启用详细性能计数器
  osd_enable_op_tracker: "true"
  osd_num_op_tracker_shard: "32"
  osd_op_history_size: "600"
  osd_op_history_duration: "600"

  # 慢操作日志
  osd_op_log_threshold: "5"
  osd_op_latency_log_threshold: "100"  # 100ms

  # 启用PG状态详细日志
  osd_pool_default_pg_autoscale_mode: "warn"
```

### 6.2 监控关键指标

```bash
# 监控OSD性能
kubectl -n poseidon exec -it <mon-pod> -- ceph osd perf

# 检查慢操作
kubectl -n poseidon exec -it <mon-pod> -- ceph daemon osd.x dump_ops_in_flight

# 统计IO延迟
kubectl -n poseidon exec -it <mon-pod> -- ceph osd histogram

# 检查PG状态
kubectl -n poseidon exec -it <mon-pod> -- ceph pg dump
```

---

## 七、基于硬件配置的建议

### 7.1 全闪存配置 (All-Flash)

```yaml
# 适用于全NVMe或全SSD集群
config:
  bluestore_min_alloc_size: "4096"
  bluestore_cache_size_ssd: "4294967296"  # 4GB
  osd_op_num_threads_per_shard: "8"
  osd_memory_target: "25769803776"  # 24GB
```

### 7.2 混合配置 (Hybrid)

```yaml
# SSD/NVMe作为DB/WAL，HDD作为数据盘
config:
  bluestore_min_alloc_size_hdd: "65536"
  bluestore_cache_size_hdd: "1073741824"  # 1GB
  osd_op_num_threads_per_shard_hdd: "4"
  osd_memory_target: "17179869184"  # 16GB
```

### 7.3 高性能配置 (Optane/NVMe)

```yaml
# 专为Intel Optane或高性能NVMe优化
config:
  bluestore_min_alloc_size: "4096"
  bluestore_spdk: "true"  # 启用SPDK
  bluestore_cache_size: "6442450944"  # 6GB
  osd_op_num_threads_per_shard: "16"
  osd_memory_target: "34359738368"  # 32GB
  osd_notslower_sleep_total: "false"
```

---

## 八、验证和调试命令

### 8.1 检查OSD配置

```bash
# 查看OSD运行时配置
kubectl -n poseidon exec -it <osd-pod> -- ceph daemon osd.x config show

# 检查特定配置
kubectl -n poseidon exec -it <osd-pod> -- \
  ceph daemon osd.x config get bluestore_min_alloc_size

# 查看性能计数器
kubectl -n poseidon exec -it <osd-pod> -- \
  ceph daemon osd.x perf dump
```

### 8.2 运行时调整配置

```bash
# 动态调整OSD配置（无需重启）
kubectl -n poseidon exec -it <mon-pod> -- \
  ceph tell osd.* injectargs '--osd_op_num_threads_per_shard 8'

# 调整BlueStore缓存
kubectl -n poseidon exec -it <mon-pod> -- \
  ceph tell osd.* injectargs '--bluestore_cache_size 3221225472'
```

### 8.3 性能测试验证

```bash
# 使用rados bench测试
kubectl -n poseidon exec -it <toolbox-pod> -- \
  rados bench -p test-pool 60 write --no-cleanup

# 读取测试
kubectl -n poseidon exec -it <toolbox-pod> -- \
  rados bench -p test-pool 60 rand

#  cleanup
kubectl -n poseidon exec -it <toolbox-pod> -- \
  rados bench -p test-pool 60 cleanup
```

---

## 九、完整Rook配置示例

```yaml
apiVersion: ceph.rook.io/v1
kind: CephCluster
metadata:
  name: rook-ceph
  namespace: poseidon
spec:
  cephVersion:
    image: quay.io/ceph/ceph:v18.2.0
    allowUnsupported: false

  cephClusterSpec:
    mon:
      count: 3
      allowMultiplePerNode: false
    mgr:
      count: 2
      modules:
      - name: pg_autoscaler
        enabled: true

    network:
      provider: host
      connections:
        requireMsgr2: true

    config:
      # 全局OSD配置
      osd_op_num_threads_per_shard: "8"
      osd_op_num_shards: "8"

      # BlueStore优化
      bluestore_min_alloc_size: "4096"
      bluestore_cache_size: "3221225472"
      bluestore_prefer_deferred_size: "32768"

      # 内存管理
      osd_memory_target: "17179869184"
      osd_memory_base: "8589934592"

      # 网络优化
      ms_bind_msgr2: "true"
      ms_async_op_threads: "4"

      # 性能监控
      osd_enable_op_tracker: "true"
      osd_op_latency_log_threshold: "100"

  storage:
    useAllNodes: false
    useAllDevices: false
    storageClassDeviceSets:
    - name: set1
      count: 3
      resources:
        limits:
          cpu: "8"
          memory: "32Gi"
        requests:
          cpu: "4"
          memory: "16Gi"
      volumeClaimTemplates:
      - metadata:
          name: data
        spec:
          resources:
            requests:
              storage: 1Ti
          storageClassName: local-storage
          volumeMode: Block
      - metadata:
          name: metadata
        spec:
          resources:
            requests:
              storage: 100Gi
          storageClassName: fast-nvme  # SSD/NVMe for metadata
          volumeMode: Block
    nodes:
    - name: "dc1-stor40"
    - name: "dc1-stor41"
    - name: "dc1-stor42"

  disruptionManagement:
    managePodBudgets: true
    machineDisruptionBudgetNamespace: poseidon
```

---

## 十、优化验证清单

在应用配置后，验证以下指标：

- [ ] OSD启动成功，无崩溃日志
- [ ] `ceph -s`显示集群状态为HEALTH_OK
- [ ] `ceph osd perf`显示延迟<10ms
- [ ] `ceph df`显示存储使用正常
- [ ] `ceph osd df`显示利用率均衡
- [ ] fio测试性能达到预期
- [ ] 网络重传率正常（<1%）
- [ ] CPU和内存使用在合理范围

---

## 注意事项

1. **逐步调整**: 一次只调整2-3个参数，观察影响
2. **监控系统**: 使用Prometheus+Grafana监控Ceph指标
3. **备份配置**: 在修改前备份现有配置
4. **测试环境**: 先在测试环境验证，再应用到生产环境
5. **版本兼容**: 确保配置项与你使用的Ceph版本兼容

---

## 参考文档

- [Ceph官方性能调优](https://docs.ceph.com/en/latest/rados/configuration/)
- [Rook-Ceph配置](https://rook.io/docs/rook/v1.12/CRDs/Cluster/ceph-cluster-crd/)
- [BlueStore优化](https://docs.ceph.com/en/latest/rados/configuration/bluestore-config-ref/)
