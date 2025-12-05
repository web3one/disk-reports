# Ceph 性能瓶颈分析报告

**分析时间**: 2025-12-03 18:51:58
**监控数据目录**: /home/ubuntu/intel-900p-hdd/rbd0/20251203_184423/ceph-monitoring

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
dm-17: 94.80%
dm-17: 96.20%
dm-17: 97.80%
rbd0: 100.00%
rbd0: 100.10%
rbd0: 90.10%
rbd0: 93.70%
rbd0: 93.80%
rbd0: 94.70%
rbd0: 94.90%
rbd0: 95.00%
rbd0: 95.40%
rbd0: 95.50%
rbd0: 95.80%
rbd0: 95.90%
rbd0: 96.10%
rbd0: 96.20%
rbd0: 96.30%
rbd0: 96.40%
rbd0: 96.50%
rbd0: 96.60%
rbd0: 96.70%
rbd0: 96.90%
rbd0: 97.00%
rbd0: 97.10%
rbd0: 97.20%
rbd0: 97.30%
rbd0: 97.40%
rbd0: 97.50%
rbd0: 97.60%
rbd0: 97.70%
rbd0: 97.80%
rbd0: 97.90%
rbd0: 98.00%
rbd0: 98.10%
rbd0: 98.20%
rbd0: 98.30%
rbd0: 98.40%
rbd0: 98.50%
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
rbd0: 99.90%
sdd: 94.90%
sdd: 96.20%
sdd: 97.70%
```

**建议**: 高利用率磁盘可能成为瓶颈，检查是否为慢盘或负载不均。

**⚠ 检测到高延迟磁盘（await > 50ms）：**
```
sda: 100.75 ms
sda: 101.00 ms
sda: 102.00 ms
sda: 102.50 ms
sda: 103.00 ms
sda: 104.00 ms
sda: 105.67 ms
sda: 107.33 ms
sda: 107.60 ms
sda: 110.50 ms
sda: 111.00 ms
sda: 112.00 ms
sda: 112.67 ms
sda: 113.00 ms
sda: 117.00 ms
sda: 118.75 ms
sda: 120.00 ms
sda: 120.50 ms
sda: 120.83 ms
sda: 121.00 ms
sda: 122.67 ms
sda: 123.00 ms
sda: 126.00 ms
sda: 129.33 ms
sda: 130.67 ms
sda: 131.67 ms
sda: 133.00 ms
sda: 134.25 ms
sda: 134.50 ms
sda: 135.17 ms
sda: 138.00 ms
sda: 50.33 ms
sda: 50.50 ms
sda: 52.75 ms
sda: 53.25 ms
sda: 53.33 ms
sda: 54.00 ms
sda: 54.75 ms
sda: 54.80 ms
sda: 55.00 ms
sda: 55.50 ms
sda: 56.67 ms
sda: 57.17 ms
sda: 58.00 ms
sda: 60.00 ms
sda: 60.25 ms
sda: 61.00 ms
sda: 63.67 ms
sda: 68.00 ms
sda: 68.38 ms
sda: 68.50 ms
sda: 68.83 ms
sda: 69.33 ms
sda: 69.83 ms
sda: 70.17 ms
sda: 71.33 ms
sda: 71.60 ms
sda: 71.67 ms
sda: 72.00 ms
sda: 73.00 ms
sda: 74.50 ms
sda: 74.67 ms
sda: 75.40 ms
sda: 76.00 ms
sda: 76.20 ms
sda: 77.00 ms
sda: 77.67 ms
sda: 78.00 ms
sda: 78.50 ms
sda: 78.71 ms
sda: 79.80 ms
sda: 80.00 ms
sda: 80.40 ms
sda: 80.60 ms
sda: 81.00 ms
sda: 82.00 ms
sda: 82.17 ms
sda: 82.33 ms
sda: 82.50 ms
sda: 83.00 ms
sda: 83.83 ms
sda: 84.00 ms
sda: 84.33 ms
sda: 84.38 ms
sda: 84.75 ms
sda: 85.00 ms
sda: 85.50 ms
sda: 86.20 ms
sda: 86.40 ms
sda: 87.17 ms
sda: 87.33 ms
sda: 87.50 ms
sda: 87.83 ms
sda: 88.33 ms
sda: 89.50 ms
sda: 90.00 ms
sda: 90.38 ms
sda: 90.60 ms
sda: 91.33 ms
sda: 91.67 ms
sda: 91.75 ms
sda: 92.11 ms
sda: 92.75 ms
sda: 94.25 ms
sda: 94.40 ms
sda: 94.50 ms
sda: 95.00 ms
sda: 95.25 ms
sda: 95.80 ms
sda: 96.00 ms
sda: 97.00 ms
sda: 97.33 ms
sda: 97.75 ms
sda: 98.00 ms
sda: 98.20 ms
sdb: 100.00 ms
sdb: 100.25 ms
sdb: 101.25 ms
sdb: 102.00 ms
sdb: 103.60 ms
sdb: 108.50 ms
sdb: 109.67 ms
sdb: 110.50 ms
sdb: 111.00 ms
sdb: 111.50 ms
sdb: 113.00 ms
sdb: 114.25 ms
sdb: 116.67 ms
sdb: 117.50 ms
sdb: 117.67 ms
sdb: 121.00 ms
sdb: 121.33 ms
sdb: 122.00 ms
sdb: 123.33 ms
sdb: 125.50 ms
sdb: 127.50 ms
sdb: 139.75 ms
sdb: 142.00 ms
sdb: 181.00 ms
sdb: 184.00 ms
sdb: 206.00 ms
sdb: 208.00 ms
sdb: 210.00 ms
sdb: 50.33 ms
sdb: 50.50 ms
sdb: 51.00 ms
sdb: 51.17 ms
sdb: 51.25 ms
sdb: 51.50 ms
sdb: 51.67 ms
sdb: 51.75 ms
sdb: 52.00 ms
sdb: 52.20 ms
sdb: 54.00 ms
sdb: 54.33 ms
sdb: 54.50 ms
sdb: 54.67 ms
sdb: 54.80 ms
sdb: 56.00 ms
sdb: 57.00 ms
sdb: 59.00 ms
sdb: 60.67 ms
sdb: 60.83 ms
sdb: 61.00 ms
sdb: 65.00 ms
sdb: 66.14 ms
sdb: 66.50 ms
sdb: 69.00 ms
sdb: 69.80 ms
sdb: 70.00 ms
sdb: 71.00 ms
sdb: 72.00 ms
sdb: 72.83 ms
sdb: 73.67 ms
sdb: 75.50 ms
sdb: 76.14 ms
sdb: 76.20 ms
sdb: 77.00 ms
sdb: 78.40 ms
sdb: 78.60 ms
sdb: 80.40 ms
sdb: 80.67 ms
sdb: 81.50 ms
sdb: 81.75 ms
sdb: 82.00 ms
sdb: 83.00 ms
sdb: 83.40 ms
sdb: 85.17 ms
sdb: 86.00 ms
sdb: 86.75 ms
sdb: 87.00 ms
sdb: 88.75 ms
sdb: 90.00 ms
sdb: 90.50 ms
sdb: 90.75 ms
sdb: 91.00 ms
sdb: 93.75 ms
sdb: 94.00 ms
sdb: 94.25 ms
sdb: 94.50 ms
sdb: 95.25 ms
sdb: 96.50 ms
sdb: 97.00 ms
sdb: 97.50 ms
sdb: 98.33 ms
sdb: 99.00 ms
sdc: 100.00 ms
sdc: 100.25 ms
sdc: 100.50 ms
sdc: 101.50 ms
sdc: 102.25 ms
sdc: 102.29 ms
sdc: 102.50 ms
sdc: 103.50 ms
sdc: 107.67 ms
sdc: 108.00 ms
sdc: 108.50 ms
sdc: 110.33 ms
sdc: 111.33 ms
sdc: 112.67 ms
sdc: 119.17 ms
sdc: 122.33 ms
sdc: 136.50 ms
sdc: 137.25 ms
sdc: 144.00 ms
sdc: 153.00 ms
sdc: 171.00 ms
sdc: 176.00 ms
sdc: 183.00 ms
sdc: 205.00 ms
sdc: 50.50 ms
sdc: 50.75 ms
sdc: 51.00 ms
sdc: 51.50 ms
sdc: 51.67 ms
sdc: 51.75 ms
sdc: 53.00 ms
sdc: 53.25 ms
sdc: 53.67 ms
sdc: 54.00 ms
sdc: 54.57 ms
sdc: 54.67 ms
sdc: 54.71 ms
sdc: 55.00 ms
sdc: 55.33 ms
sdc: 55.50 ms
sdc: 56.00 ms
sdc: 56.67 ms
sdc: 58.00 ms
sdc: 59.00 ms
sdc: 59.33 ms
sdc: 60.67 ms
sdc: 60.75 ms
sdc: 61.50 ms
sdc: 62.67 ms
sdc: 62.80 ms
sdc: 64.83 ms
sdc: 67.00 ms
sdc: 67.25 ms
sdc: 67.67 ms
sdc: 69.00 ms
sdc: 69.75 ms
sdc: 69.80 ms
sdc: 70.33 ms
sdc: 71.00 ms
sdc: 71.67 ms
sdc: 73.80 ms
sdc: 74.57 ms
sdc: 74.60 ms
sdc: 74.67 ms
sdc: 75.00 ms
sdc: 75.33 ms
sdc: 75.60 ms
sdc: 75.80 ms
sdc: 76.80 ms
sdc: 77.25 ms
sdc: 77.40 ms
sdc: 78.33 ms
sdc: 79.20 ms
sdc: 79.50 ms
sdc: 81.17 ms
sdc: 81.40 ms
sdc: 82.75 ms
sdc: 83.00 ms
sdc: 83.40 ms
sdc: 84.38 ms
sdc: 84.50 ms
sdc: 84.75 ms
sdc: 85.50 ms
sdc: 85.67 ms
sdc: 86.50 ms
sdc: 87.50 ms
sdc: 88.00 ms
sdc: 88.25 ms
sdc: 88.75 ms
sdc: 89.50 ms
sdc: 90.50 ms
sdc: 91.00 ms
sdc: 91.75 ms
sdc: 92.00 ms
sdc: 92.25 ms
sdc: 93.00 ms
sdc: 93.50 ms
sdc: 94.25 ms
sdc: 94.75 ms
sdc: 95.00 ms
sdc: 95.50 ms
sdc: 95.71 ms
sdc: 96.00 ms
sdc: 96.80 ms
sdc: 98.00 ms
sdc: 98.25 ms
sdc: 98.75 ms
sdc: 99.00 ms
sdc: 99.50 ms
sdc: 99.75 ms
sdd: 100.50 ms
sdd: 101.00 ms
sdd: 101.25 ms
sdd: 101.50 ms
sdd: 103.00 ms
sdd: 103.20 ms
sdd: 104.00 ms
sdd: 104.50 ms
sdd: 106.00 ms
sdd: 106.50 ms
sdd: 106.75 ms
sdd: 107.43 ms
sdd: 108.00 ms
sdd: 109.00 ms
sdd: 109.33 ms
sdd: 111.00 ms
sdd: 111.67 ms
sdd: 112.00 ms
sdd: 118.20 ms
sdd: 119.67 ms
sdd: 120.00 ms
sdd: 121.33 ms
sdd: 122.00 ms
sdd: 125.83 ms
sdd: 126.83 ms
sdd: 127.33 ms
sdd: 130.67 ms
sdd: 132.25 ms
sdd: 137.00 ms
sdd: 140.00 ms
sdd: 143.00 ms
sdd: 143.25 ms
sdd: 143.71 ms
sdd: 150.20 ms
sdd: 154.00 ms
sdd: 157.00 ms
sdd: 160.50 ms
sdd: 167.00 ms
sdd: 172.00 ms
sdd: 181.00 ms
sdd: 182.00 ms
sdd: 50.33 ms
sdd: 50.50 ms
sdd: 50.75 ms
sdd: 51.00 ms
sdd: 51.17 ms
sdd: 51.25 ms
sdd: 51.50 ms
sdd: 51.67 ms
sdd: 52.17 ms
sdd: 52.20 ms
sdd: 52.40 ms
sdd: 54.00 ms
sdd: 55.00 ms
sdd: 55.83 ms
sdd: 55.88 ms
sdd: 56.57 ms
sdd: 57.12 ms
sdd: 57.33 ms
sdd: 59.38 ms
sdd: 60.50 ms
sdd: 61.17 ms
sdd: 61.50 ms
sdd: 62.50 ms
sdd: 62.75 ms
sdd: 64.00 ms
sdd: 65.00 ms
sdd: 65.33 ms
sdd: 65.43 ms
sdd: 67.33 ms
sdd: 67.40 ms
sdd: 67.50 ms
sdd: 68.38 ms
sdd: 68.43 ms
sdd: 69.38 ms
sdd: 70.33 ms
sdd: 70.75 ms
sdd: 71.17 ms
sdd: 71.22 ms
sdd: 71.50 ms
sdd: 71.67 ms
sdd: 71.75 ms
sdd: 72.00 ms
sdd: 73.75 ms
sdd: 74.17 ms
sdd: 74.40 ms
sdd: 74.71 ms
sdd: 74.75 ms
sdd: 74.80 ms
sdd: 75.33 ms
sdd: 76.40 ms
sdd: 76.67 ms
sdd: 76.80 ms
sdd: 77.14 ms
sdd: 77.17 ms
sdd: 77.86 ms
sdd: 78.00 ms
sdd: 78.67 ms
sdd: 79.17 ms
sdd: 79.67 ms
sdd: 80.00 ms
sdd: 80.14 ms
sdd: 81.50 ms
sdd: 81.67 ms
sdd: 82.17 ms
sdd: 82.60 ms
sdd: 82.80 ms
sdd: 82.83 ms
sdd: 83.00 ms
sdd: 83.40 ms
sdd: 83.60 ms
sdd: 83.80 ms
sdd: 84.33 ms
sdd: 84.75 ms
sdd: 84.80 ms
sdd: 84.83 ms
sdd: 85.00 ms
sdd: 85.88 ms
sdd: 86.75 ms
sdd: 87.17 ms
sdd: 87.20 ms
sdd: 87.40 ms
sdd: 88.00 ms
sdd: 88.33 ms
sdd: 88.75 ms
sdd: 89.17 ms
sdd: 91.25 ms
sdd: 91.75 ms
sdd: 92.00 ms
sdd: 92.14 ms
sdd: 92.25 ms
sdd: 92.50 ms
sdd: 94.00 ms
sdd: 95.00 ms
sdd: 96.50 ms
sdd: 98.00 ms
sdd: 99.00 ms
sde: 100.25 ms
sde: 101.00 ms
sde: 101.50 ms
sde: 102.00 ms
sde: 103.00 ms
sde: 104.00 ms
sde: 106.50 ms
sde: 107.50 ms
sde: 108.00 ms
sde: 108.43 ms
sde: 109.00 ms
sde: 110.67 ms
sde: 110.75 ms
sde: 113.00 ms
sde: 114.33 ms
sde: 118.33 ms
sde: 119.00 ms
sde: 119.33 ms
sde: 120.50 ms
sde: 125.67 ms
sde: 126.75 ms
sde: 131.00 ms
sde: 133.00 ms
sde: 137.00 ms
sde: 140.00 ms
sde: 143.00 ms
sde: 150.25 ms
sde: 164.00 ms
sde: 176.50 ms
sde: 183.00 ms
sde: 213.00 ms
sde: 223.00 ms
sde: 50.25 ms
sde: 50.50 ms
sde: 50.75 ms
sde: 51.00 ms
sde: 51.60 ms
sde: 51.67 ms
sde: 51.75 ms
sde: 52.00 ms
sde: 52.33 ms
sde: 52.50 ms
sde: 52.80 ms
sde: 53.67 ms
sde: 54.29 ms
sde: 54.75 ms
sde: 55.00 ms
sde: 56.33 ms
sde: 57.00 ms
sde: 57.17 ms
sde: 57.80 ms
sde: 58.00 ms
sde: 58.25 ms
sde: 59.00 ms
sde: 59.75 ms
sde: 59.80 ms
sde: 60.00 ms
sde: 60.14 ms
sde: 61.00 ms
sde: 61.20 ms
sde: 62.67 ms
sde: 64.00 ms
sde: 64.50 ms
sde: 65.00 ms
sde: 65.83 ms
sde: 66.60 ms
sde: 67.33 ms
sde: 67.80 ms
sde: 68.75 ms
sde: 69.33 ms
sde: 71.00 ms
sde: 71.50 ms
sde: 73.00 ms
sde: 73.83 ms
sde: 74.17 ms
sde: 75.80 ms
sde: 77.60 ms
sde: 79.00 ms
sde: 79.33 ms
sde: 80.20 ms
sde: 80.33 ms
sde: 81.00 ms
sde: 81.67 ms
sde: 81.83 ms
sde: 82.50 ms
sde: 82.67 ms
sde: 83.20 ms
sde: 84.00 ms
sde: 84.25 ms
sde: 84.50 ms
sde: 86.33 ms
sde: 86.40 ms
sde: 87.75 ms
sde: 88.00 ms
sde: 88.50 ms
sde: 90.00 ms
sde: 91.00 ms
sde: 91.50 ms
sde: 91.75 ms
sde: 93.25 ms
sde: 93.75 ms
sde: 94.17 ms
sde: 94.75 ms
sde: 95.00 ms
sde: 95.67 ms
sde: 95.75 ms
sde: 96.00 ms
sde: 97.25 ms
sde: 97.33 ms
sde: 97.75 ms
sde: 98.50 ms
sde: 99.25 ms
sde: 99.75 ms
sdf: 100.00 ms
sdf: 100.75 ms
sdf: 101.00 ms
sdf: 101.75 ms
sdf: 102.00 ms
sdf: 102.25 ms
sdf: 103.00 ms
sdf: 103.75 ms
sdf: 104.00 ms
sdf: 109.33 ms
sdf: 111.00 ms
sdf: 112.00 ms
sdf: 114.67 ms
sdf: 115.33 ms
sdf: 116.00 ms
sdf: 116.50 ms
sdf: 118.00 ms
sdf: 118.17 ms
sdf: 119.33 ms
sdf: 121.00 ms
sdf: 127.17 ms
sdf: 130.00 ms
sdf: 137.00 ms
sdf: 142.75 ms
sdf: 153.25 ms
sdf: 157.00 ms
sdf: 177.00 ms
sdf: 183.00 ms
sdf: 50.17 ms
sdf: 50.25 ms
sdf: 50.80 ms
sdf: 51.00 ms
sdf: 51.17 ms
sdf: 52.67 ms
sdf: 54.00 ms
sdf: 54.50 ms
sdf: 55.50 ms
sdf: 56.17 ms
sdf: 56.33 ms
sdf: 56.67 ms
sdf: 57.25 ms
sdf: 58.67 ms
sdf: 59.25 ms
sdf: 59.33 ms
sdf: 60.00 ms
sdf: 60.50 ms
sdf: 63.00 ms
sdf: 63.67 ms
sdf: 64.00 ms
sdf: 64.25 ms
sdf: 64.33 ms
sdf: 67.00 ms
sdf: 67.67 ms
sdf: 69.00 ms
sdf: 69.33 ms
sdf: 71.17 ms
sdf: 71.25 ms
sdf: 73.00 ms
sdf: 74.00 ms
sdf: 75.00 ms
sdf: 75.33 ms
sdf: 75.75 ms
sdf: 75.80 ms
sdf: 76.29 ms
sdf: 76.50 ms
sdf: 76.60 ms
sdf: 76.80 ms
sdf: 77.00 ms
sdf: 78.71 ms
sdf: 79.50 ms
sdf: 79.60 ms
sdf: 81.33 ms
sdf: 81.83 ms
sdf: 82.33 ms
sdf: 83.00 ms
sdf: 83.20 ms
sdf: 83.50 ms
sdf: 83.67 ms
sdf: 83.75 ms
sdf: 84.25 ms
sdf: 84.67 ms
sdf: 84.83 ms
sdf: 86.50 ms
sdf: 86.75 ms
sdf: 87.25 ms
sdf: 87.33 ms
sdf: 87.50 ms
sdf: 87.67 ms
sdf: 90.75 ms
sdf: 91.00 ms
sdf: 91.25 ms
sdf: 91.75 ms
sdf: 91.83 ms
sdf: 92.75 ms
sdf: 92.80 ms
sdf: 94.25 ms
sdf: 94.50 ms
sdf: 94.75 ms
sdf: 95.25 ms
sdf: 95.50 ms
sdf: 96.20 ms
sdf: 96.25 ms
sdf: 96.75 ms
sdf: 97.20 ms
sdf: 97.50 ms
sdf: 97.80 ms
sdf: 98.20 ms
sdf: 99.25 ms
sdf: 99.75 ms
sdg: 100.25 ms
sdg: 100.75 ms
sdg: 101.75 ms
sdg: 102.00 ms
sdg: 102.50 ms
sdg: 104.00 ms
sdg: 104.75 ms
sdg: 105.25 ms
sdg: 106.50 ms
sdg: 107.00 ms
sdg: 108.50 ms
sdg: 110.50 ms
sdg: 114.50 ms
sdg: 115.33 ms
sdg: 115.50 ms
sdg: 116.33 ms
sdg: 118.33 ms
sdg: 119.00 ms
sdg: 119.50 ms
sdg: 120.00 ms
sdg: 120.17 ms
sdg: 122.00 ms
sdg: 122.33 ms
sdg: 125.00 ms
sdg: 131.00 ms
sdg: 50.33 ms
sdg: 50.50 ms
sdg: 50.67 ms
sdg: 50.83 ms
sdg: 51.67 ms
sdg: 51.80 ms
sdg: 52.25 ms
sdg: 52.50 ms
sdg: 52.67 ms
sdg: 52.75 ms
sdg: 53.00 ms
sdg: 53.20 ms
sdg: 53.40 ms
sdg: 53.50 ms
sdg: 53.67 ms
sdg: 54.00 ms
sdg: 54.67 ms
sdg: 55.25 ms
sdg: 55.50 ms
sdg: 56.00 ms
sdg: 57.20 ms
sdg: 57.25 ms
sdg: 57.33 ms
sdg: 57.60 ms
sdg: 57.80 ms
sdg: 58.25 ms
sdg: 58.33 ms
sdg: 59.25 ms
sdg: 59.33 ms
sdg: 59.50 ms
sdg: 60.00 ms
sdg: 60.67 ms
sdg: 61.00 ms
sdg: 61.57 ms
sdg: 61.67 ms
sdg: 62.67 ms
sdg: 63.00 ms
sdg: 63.60 ms
sdg: 63.67 ms
sdg: 64.00 ms
sdg: 64.67 ms
sdg: 65.00 ms
sdg: 67.00 ms
sdg: 67.14 ms
sdg: 67.50 ms
sdg: 67.67 ms
sdg: 68.50 ms
sdg: 68.71 ms
sdg: 70.50 ms
sdg: 72.33 ms
sdg: 73.67 ms
sdg: 75.50 ms
sdg: 76.33 ms
sdg: 76.40 ms
sdg: 78.00 ms
sdg: 78.40 ms
sdg: 79.00 ms
sdg: 79.62 ms
sdg: 80.20 ms
sdg: 80.33 ms
sdg: 81.40 ms
sdg: 81.80 ms
sdg: 82.83 ms
sdg: 83.00 ms
sdg: 84.00 ms
sdg: 84.33 ms
sdg: 85.00 ms
sdg: 85.83 ms
sdg: 86.00 ms
sdg: 86.40 ms
sdg: 87.00 ms
sdg: 88.00 ms
sdg: 88.17 ms
sdg: 88.83 ms
sdg: 89.25 ms
sdg: 89.88 ms
sdg: 90.00 ms
sdg: 90.17 ms
sdg: 90.25 ms
sdg: 90.43 ms
sdg: 91.00 ms
sdg: 92.20 ms
sdg: 92.50 ms
sdg: 93.00 ms
sdg: 95.60 ms
sdg: 95.75 ms
sdg: 97.00 ms
sdg: 97.60 ms
sdg: 98.25 ms
sdg: 99.00 ms
sdg: 99.50 ms
sdh: 100.25 ms
sdh: 100.75 ms
sdh: 101.25 ms
sdh: 102.25 ms
sdh: 103.00 ms
sdh: 103.75 ms
sdh: 104.00 ms
sdh: 105.25 ms
sdh: 106.25 ms
sdh: 107.00 ms
sdh: 107.25 ms
sdh: 109.00 ms
sdh: 112.50 ms
sdh: 117.50 ms
sdh: 118.50 ms
sdh: 119.67 ms
sdh: 123.33 ms
sdh: 123.83 ms
sdh: 127.00 ms
sdh: 128.33 ms
sdh: 135.75 ms
sdh: 138.75 ms
sdh: 162.00 ms
sdh: 177.00 ms
sdh: 50.25 ms
sdh: 50.33 ms
sdh: 51.17 ms
sdh: 52.67 ms
sdh: 53.00 ms
sdh: 53.17 ms
sdh: 53.75 ms
sdh: 54.00 ms
sdh: 54.25 ms
sdh: 54.50 ms
sdh: 55.33 ms
sdh: 55.60 ms
sdh: 56.25 ms
sdh: 56.50 ms
sdh: 56.75 ms
sdh: 57.50 ms
sdh: 57.88 ms
sdh: 58.00 ms
sdh: 58.67 ms
sdh: 58.89 ms
sdh: 59.00 ms
sdh: 59.25 ms
sdh: 59.50 ms
sdh: 59.75 ms
sdh: 60.33 ms
sdh: 61.00 ms
sdh: 62.25 ms
sdh: 62.33 ms
sdh: 63.57 ms
sdh: 63.78 ms
sdh: 65.60 ms
sdh: 66.25 ms
sdh: 66.80 ms
sdh: 67.50 ms
sdh: 67.67 ms
sdh: 68.50 ms
sdh: 68.75 ms
sdh: 69.00 ms
sdh: 69.67 ms
sdh: 70.38 ms
sdh: 70.89 ms
sdh: 72.00 ms
sdh: 72.17 ms
sdh: 72.50 ms
sdh: 72.67 ms
sdh: 73.67 ms
sdh: 74.00 ms
sdh: 74.50 ms
sdh: 75.29 ms
sdh: 75.40 ms
sdh: 75.83 ms
sdh: 76.20 ms
sdh: 77.57 ms
sdh: 77.60 ms
sdh: 79.00 ms
sdh: 79.40 ms
sdh: 79.60 ms
sdh: 79.83 ms
sdh: 80.33 ms
sdh: 80.43 ms
sdh: 81.33 ms
sdh: 81.50 ms
sdh: 82.40 ms
sdh: 82.43 ms
sdh: 83.00 ms
sdh: 83.29 ms
sdh: 83.71 ms
sdh: 84.17 ms
sdh: 84.33 ms
sdh: 84.71 ms
sdh: 85.60 ms
sdh: 85.80 ms
sdh: 86.25 ms
sdh: 86.50 ms
sdh: 87.00 ms
sdh: 87.33 ms
sdh: 88.50 ms
sdh: 89.20 ms
sdh: 89.50 ms
sdh: 89.83 ms
sdh: 90.83 ms
sdh: 92.25 ms
sdh: 92.38 ms
sdh: 93.50 ms
sdh: 95.00 ms
sdh: 95.25 ms
sdh: 95.50 ms
sdh: 95.62 ms
sdh: 95.75 ms
sdh: 96.00 ms
sdh: 96.50 ms
sdh: 96.75 ms
sdh: 97.00 ms
sdh: 97.25 ms
sdh: 97.57 ms
sdh: 97.83 ms
sdh: 98.00 ms
sdh: 99.00 ms
sdh: 99.40 ms
sdi: 100.00 ms
sdi: 101.00 ms
sdi: 102.25 ms
sdi: 102.50 ms
sdi: 102.60 ms
sdi: 104.00 ms
sdi: 104.25 ms
sdi: 104.57 ms
sdi: 106.00 ms
sdi: 108.25 ms
sdi: 108.67 ms
sdi: 109.00 ms
sdi: 112.00 ms
sdi: 113.00 ms
sdi: 113.33 ms
sdi: 115.00 ms
sdi: 115.50 ms
sdi: 118.00 ms
sdi: 118.33 ms
sdi: 119.00 ms
sdi: 120.00 ms
sdi: 122.00 ms
sdi: 122.83 ms
sdi: 123.67 ms
sdi: 124.00 ms
sdi: 124.67 ms
sdi: 127.17 ms
sdi: 139.50 ms
sdi: 141.75 ms
sdi: 148.00 ms
sdi: 150.75 ms
sdi: 174.00 ms
sdi: 183.00 ms
sdi: 195.00 ms
sdi: 201.00 ms
sdi: 52.00 ms
sdi: 52.29 ms
sdi: 52.33 ms
sdi: 52.67 ms
sdi: 53.00 ms
sdi: 53.33 ms
sdi: 53.50 ms
sdi: 53.60 ms
sdi: 54.00 ms
sdi: 55.57 ms
sdi: 56.33 ms
sdi: 57.33 ms
sdi: 58.00 ms
sdi: 58.33 ms
sdi: 58.50 ms
sdi: 59.33 ms
sdi: 59.40 ms
sdi: 60.00 ms
sdi: 60.33 ms
sdi: 61.00 ms
sdi: 61.29 ms
sdi: 61.33 ms
sdi: 62.00 ms
sdi: 62.67 ms
sdi: 62.80 ms
sdi: 64.33 ms
sdi: 66.17 ms
sdi: 68.00 ms
sdi: 69.67 ms
sdi: 71.00 ms
sdi: 73.00 ms
sdi: 73.17 ms
sdi: 73.88 ms
sdi: 74.00 ms
sdi: 75.25 ms
sdi: 75.67 ms
sdi: 76.00 ms
sdi: 77.14 ms
sdi: 77.40 ms
sdi: 77.50 ms
sdi: 78.00 ms
sdi: 78.33 ms
sdi: 78.40 ms
sdi: 79.50 ms
sdi: 80.20 ms
sdi: 81.50 ms
sdi: 82.00 ms
sdi: 82.83 ms
sdi: 83.00 ms
sdi: 83.75 ms
sdi: 84.83 ms
sdi: 85.40 ms
sdi: 87.00 ms
sdi: 88.50 ms
sdi: 89.25 ms
sdi: 89.83 ms
sdi: 90.25 ms
sdi: 90.75 ms
sdi: 91.00 ms
sdi: 91.75 ms
sdi: 92.00 ms
sdi: 92.25 ms
sdi: 93.75 ms
sdi: 94.00 ms
sdi: 95.00 ms
sdi: 97.25 ms
sdi: 98.00 ms
sdi: 98.67 ms
sdi: 99.25 ms
sdj: 100.50 ms
sdj: 101.50 ms
sdj: 102.50 ms
sdj: 102.75 ms
sdj: 105.50 ms
sdj: 109.50 ms
sdj: 111.00 ms
sdj: 119.75 ms
sdj: 121.33 ms
sdj: 127.67 ms
sdj: 132.00 ms
sdj: 135.33 ms
sdj: 136.50 ms
sdj: 141.00 ms
sdj: 142.00 ms
sdj: 142.50 ms
sdj: 148.00 ms
sdj: 152.33 ms
sdj: 154.50 ms
sdj: 163.00 ms
sdj: 183.00 ms
sdj: 50.25 ms
sdj: 50.50 ms
sdj: 50.67 ms
sdj: 50.75 ms
sdj: 51.25 ms
sdj: 51.33 ms
sdj: 51.67 ms
sdj: 51.75 ms
sdj: 52.00 ms
sdj: 52.25 ms
sdj: 52.50 ms
sdj: 52.60 ms
sdj: 52.67 ms
sdj: 53.00 ms
sdj: 53.20 ms
sdj: 53.60 ms
sdj: 53.75 ms
sdj: 54.00 ms
sdj: 54.44 ms
sdj: 55.20 ms
sdj: 55.33 ms
sdj: 55.50 ms
sdj: 55.75 ms
sdj: 56.67 ms
sdj: 56.75 ms
sdj: 57.33 ms
sdj: 57.50 ms
sdj: 57.67 ms
sdj: 59.33 ms
sdj: 61.67 ms
sdj: 62.67 ms
sdj: 63.57 ms
sdj: 63.67 ms
sdj: 64.00 ms
sdj: 64.29 ms
sdj: 64.67 ms
sdj: 64.86 ms
sdj: 66.33 ms
sdj: 66.83 ms
sdj: 67.86 ms
sdj: 68.33 ms
sdj: 68.83 ms
sdj: 69.83 ms
sdj: 70.00 ms
sdj: 70.50 ms
sdj: 71.50 ms
sdj: 71.80 ms
sdj: 72.14 ms
sdj: 73.50 ms
sdj: 74.50 ms
sdj: 75.00 ms
sdj: 76.33 ms
sdj: 76.67 ms
sdj: 77.33 ms
sdj: 77.60 ms
sdj: 78.33 ms
sdj: 78.57 ms
sdj: 78.83 ms
sdj: 79.17 ms
sdj: 79.20 ms
sdj: 80.67 ms
sdj: 81.00 ms
sdj: 81.20 ms
sdj: 81.75 ms
sdj: 82.00 ms
sdj: 82.12 ms
sdj: 83.60 ms
sdj: 84.20 ms
sdj: 84.75 ms
sdj: 85.17 ms
sdj: 85.40 ms
sdj: 85.60 ms
sdj: 85.67 ms
sdj: 85.75 ms
sdj: 85.80 ms
sdj: 86.80 ms
sdj: 87.33 ms
sdj: 87.50 ms
sdj: 88.75 ms
sdj: 89.00 ms
sdj: 89.75 ms
sdj: 91.75 ms
sdj: 93.50 ms
sdj: 93.67 ms
sdj: 93.75 ms
sdj: 95.00 ms
sdj: 95.25 ms
sdj: 95.50 ms
sdj: 95.80 ms
sdj: 96.50 ms
sdj: 96.75 ms
sdj: 97.25 ms
sdj: 97.75 ms
sdj: 98.00 ms
sdj: 99.00 ms
sdj: 99.25 ms
sdj: 99.75 ms
sdk: 100.00 ms
sdk: 100.25 ms
sdk: 100.75 ms
sdk: 101.25 ms
sdk: 101.50 ms
sdk: 101.75 ms
sdk: 102.50 ms
sdk: 104.00 ms
sdk: 105.00 ms
sdk: 106.25 ms
sdk: 108.33 ms
sdk: 108.50 ms
sdk: 111.50 ms
sdk: 111.67 ms
sdk: 113.67 ms
sdk: 114.33 ms
sdk: 115.00 ms
sdk: 116.33 ms
sdk: 120.50 ms
sdk: 120.67 ms
sdk: 125.67 ms
sdk: 125.75 ms
sdk: 126.00 ms
sdk: 127.00 ms
sdk: 127.33 ms
sdk: 128.75 ms
sdk: 133.00 ms
sdk: 134.75 ms
sdk: 135.00 ms
sdk: 141.75 ms
sdk: 149.00 ms
sdk: 170.00 ms
sdk: 172.50 ms
sdk: 189.00 ms
sdk: 208.00 ms
sdk: 50.33 ms
sdk: 50.50 ms
sdk: 50.75 ms
sdk: 51.50 ms
sdk: 52.50 ms
sdk: 52.67 ms
sdk: 53.50 ms
sdk: 54.17 ms
sdk: 54.33 ms
sdk: 54.67 ms
sdk: 55.75 ms
sdk: 56.00 ms
sdk: 56.50 ms
sdk: 57.33 ms
sdk: 58.17 ms
sdk: 58.67 ms
sdk: 58.75 ms
sdk: 59.25 ms
sdk: 59.33 ms
sdk: 59.67 ms
sdk: 61.17 ms
sdk: 62.67 ms
sdk: 63.67 ms
sdk: 64.25 ms
sdk: 65.00 ms
sdk: 67.40 ms
sdk: 68.14 ms
sdk: 68.67 ms
sdk: 69.00 ms
sdk: 72.50 ms
sdk: 72.67 ms
sdk: 73.33 ms
sdk: 73.50 ms
sdk: 75.00 ms
sdk: 77.00 ms
sdk: 77.67 ms
sdk: 77.80 ms
sdk: 78.20 ms
sdk: 79.00 ms
sdk: 79.50 ms
sdk: 79.80 ms
sdk: 80.33 ms
sdk: 80.40 ms
sdk: 80.50 ms
sdk: 81.83 ms
sdk: 82.80 ms
sdk: 83.00 ms
sdk: 83.50 ms
sdk: 84.80 ms
sdk: 86.00 ms
sdk: 87.00 ms
sdk: 87.44 ms
sdk: 90.25 ms
sdk: 90.75 ms
sdk: 91.75 ms
sdk: 94.00 ms
sdk: 95.00 ms
sdk: 96.25 ms
sdk: 96.75 ms
sdk: 99.25 ms
sdk: 99.75 ms
sdl: 101.00 ms
sdl: 101.50 ms
sdl: 103.50 ms
sdl: 104.00 ms
sdl: 104.50 ms
sdl: 105.00 ms
sdl: 106.50 ms
sdl: 107.00 ms
sdl: 108.50 ms
sdl: 111.50 ms
sdl: 113.00 ms
sdl: 115.00 ms
sdl: 116.50 ms
sdl: 117.00 ms
sdl: 119.29 ms
sdl: 120.33 ms
sdl: 123.17 ms
sdl: 125.00 ms
sdl: 128.00 ms
sdl: 129.33 ms
sdl: 134.00 ms
sdl: 138.50 ms
sdl: 140.25 ms
sdl: 146.25 ms
sdl: 175.50 ms
sdl: 186.00 ms
sdl: 187.00 ms
sdl: 50.25 ms
sdl: 50.50 ms
sdl: 50.67 ms
sdl: 50.86 ms
sdl: 51.60 ms
sdl: 51.67 ms
sdl: 52.00 ms
sdl: 52.50 ms
sdl: 52.67 ms
sdl: 52.75 ms
sdl: 53.00 ms
sdl: 53.25 ms
sdl: 54.00 ms
sdl: 56.00 ms
sdl: 57.00 ms
sdl: 60.00 ms
sdl: 60.33 ms
sdl: 60.50 ms
sdl: 61.67 ms
sdl: 62.25 ms
sdl: 62.40 ms
sdl: 62.67 ms
sdl: 64.33 ms
sdl: 67.33 ms
sdl: 71.33 ms
sdl: 72.67 ms
sdl: 73.50 ms
sdl: 73.83 ms
sdl: 75.14 ms
sdl: 75.67 ms
sdl: 76.38 ms
sdl: 76.50 ms
sdl: 76.60 ms
sdl: 78.00 ms
sdl: 79.17 ms
sdl: 79.33 ms
sdl: 80.75 ms
sdl: 81.17 ms
sdl: 81.60 ms
sdl: 81.80 ms
sdl: 82.00 ms
sdl: 82.33 ms
sdl: 82.60 ms
sdl: 83.20 ms
sdl: 83.60 ms
sdl: 84.40 ms
sdl: 85.00 ms
sdl: 85.83 ms
sdl: 86.50 ms
sdl: 87.17 ms
sdl: 88.67 ms
sdl: 89.40 ms
sdl: 91.00 ms
sdl: 92.50 ms
sdl: 92.75 ms
sdl: 93.00 ms
sdl: 93.50 ms
sdl: 93.75 ms
sdl: 94.50 ms
sdl: 95.00 ms
sdl: 95.50 ms
sdl: 95.75 ms
sdl: 96.00 ms
sdl: 96.50 ms
sdl: 99.25 ms
sdl: 99.75 ms
```

---

### 网络问题分析

⚠ **检测到网络问题**

**重传统计：**
    45946 segments retransmitted
    30540 fast retransmits
    643 retransmits in slow start

**错误/丢包：**
```
    20 outgoing packets dropped
    8 dropped because of missing route
    0 packet receive errors
    0 receive buffer errors
    0 send buffer errors
```

**建议**: 网络重传或丢包可能导致延迟抖动，检查交换机/网卡配置。

---

### 内核 I/O 错误分析

⚠ **检测到 286 条内核 I/O 相关错误**

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

