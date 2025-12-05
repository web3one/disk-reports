# Ceph 性能瓶颈分析报告

**分析时间**: 2025-12-03 13:30:37
**监控数据目录**: /home/ubuntu/intel-900p-hdd/rbd0/20251203_132303/ceph-monitoring

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
rbd0: 90.50%
rbd0: 95.20%
rbd0: 95.80%
rbd0: 95.90%
rbd0: 96.00%
rbd0: 96.30%
rbd0: 96.40%
rbd0: 96.50%
rbd0: 96.60%
rbd0: 96.80%
rbd0: 96.90%
rbd0: 97.00%
rbd0: 97.10%
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
rbd0: 99.50%
rbd0: 99.60%
rbd0: 99.90%
```

**建议**: 高利用率磁盘可能成为瓶颈，检查是否为慢盘或负载不均。

**⚠ 检测到高延迟磁盘（await > 50ms）：**
```
sda: 100.00 ms
sda: 100.50 ms
sda: 100.75 ms
sda: 101.00 ms
sda: 101.25 ms
sda: 101.75 ms
sda: 104.00 ms
sda: 105.71 ms
sda: 105.75 ms
sda: 109.75 ms
sda: 111.00 ms
sda: 111.29 ms
sda: 113.00 ms
sda: 114.83 ms
sda: 115.00 ms
sda: 116.33 ms
sda: 116.67 ms
sda: 117.33 ms
sda: 118.33 ms
sda: 118.80 ms
sda: 119.33 ms
sda: 121.17 ms
sda: 122.17 ms
sda: 123.00 ms
sda: 124.00 ms
sda: 125.00 ms
sda: 125.67 ms
sda: 129.67 ms
sda: 130.33 ms
sda: 139.25 ms
sda: 141.00 ms
sda: 145.00 ms
sda: 152.00 ms
sda: 156.00 ms
sda: 181.00 ms
sda: 197.00 ms
sda: 50.17 ms
sda: 50.50 ms
sda: 51.00 ms
sda: 51.25 ms
sda: 51.29 ms
sda: 52.00 ms
sda: 52.17 ms
sda: 52.25 ms
sda: 52.50 ms
sda: 52.67 ms
sda: 53.25 ms
sda: 53.67 ms
sda: 54.00 ms
sda: 54.14 ms
sda: 54.33 ms
sda: 54.50 ms
sda: 54.60 ms
sda: 54.75 ms
sda: 55.83 ms
sda: 56.62 ms
sda: 58.60 ms
sda: 58.67 ms
sda: 59.00 ms
sda: 60.00 ms
sda: 63.25 ms
sda: 64.00 ms
sda: 64.50 ms
sda: 64.67 ms
sda: 67.29 ms
sda: 67.50 ms
sda: 67.75 ms
sda: 68.75 ms
sda: 69.40 ms
sda: 70.33 ms
sda: 71.33 ms
sda: 72.14 ms
sda: 72.33 ms
sda: 74.57 ms
sda: 75.17 ms
sda: 75.67 ms
sda: 76.00 ms
sda: 76.83 ms
sda: 77.00 ms
sda: 77.33 ms
sda: 77.67 ms
sda: 77.83 ms
sda: 78.50 ms
sda: 78.60 ms
sda: 80.17 ms
sda: 80.20 ms
sda: 80.75 ms
sda: 80.80 ms
sda: 82.20 ms
sda: 82.67 ms
sda: 84.33 ms
sda: 84.78 ms
sda: 85.17 ms
sda: 85.50 ms
sda: 86.17 ms
sda: 86.25 ms
sda: 86.67 ms
sda: 87.00 ms
sda: 87.25 ms
sda: 87.33 ms
sda: 87.80 ms
sda: 90.75 ms
sda: 91.00 ms
sda: 91.25 ms
sda: 91.50 ms
sda: 92.00 ms
sda: 92.33 ms
sda: 93.00 ms
sda: 93.17 ms
sda: 93.80 ms
sda: 94.25 ms
sda: 94.50 ms
sda: 94.75 ms
sda: 95.00 ms
sda: 96.75 ms
sdb: 102.50 ms
sdb: 103.00 ms
sdb: 106.00 ms
sdb: 107.50 ms
sdb: 107.80 ms
sdb: 108.50 ms
sdb: 111.50 ms
sdb: 112.33 ms
sdb: 113.00 ms
sdb: 113.33 ms
sdb: 115.00 ms
sdb: 116.00 ms
sdb: 118.50 ms
sdb: 119.00 ms
sdb: 121.33 ms
sdb: 122.00 ms
sdb: 122.67 ms
sdb: 123.33 ms
sdb: 124.33 ms
sdb: 125.33 ms
sdb: 126.50 ms
sdb: 126.83 ms
sdb: 127.33 ms
sdb: 130.25 ms
sdb: 135.00 ms
sdb: 178.50 ms
sdb: 188.00 ms
sdb: 193.00 ms
sdb: 223.00 ms
sdb: 50.50 ms
sdb: 50.67 ms
sdb: 50.80 ms
sdb: 51.40 ms
sdb: 51.75 ms
sdb: 52.00 ms
sdb: 52.20 ms
sdb: 52.75 ms
sdb: 53.00 ms
sdb: 53.20 ms
sdb: 53.33 ms
sdb: 54.50 ms
sdb: 55.50 ms
sdb: 56.33 ms
sdb: 56.60 ms
sdb: 56.80 ms
sdb: 57.38 ms
sdb: 57.80 ms
sdb: 58.33 ms
sdb: 59.33 ms
sdb: 60.60 ms
sdb: 61.00 ms
sdb: 61.33 ms
sdb: 62.00 ms
sdb: 63.17 ms
sdb: 64.00 ms
sdb: 64.67 ms
sdb: 65.00 ms
sdb: 65.60 ms
sdb: 67.33 ms
sdb: 68.14 ms
sdb: 68.57 ms
sdb: 69.00 ms
sdb: 69.17 ms
sdb: 69.43 ms
sdb: 71.00 ms
sdb: 72.17 ms
sdb: 74.00 ms
sdb: 74.25 ms
sdb: 74.67 ms
sdb: 77.00 ms
sdb: 77.83 ms
sdb: 78.00 ms
sdb: 80.00 ms
sdb: 80.33 ms
sdb: 80.67 ms
sdb: 80.80 ms
sdb: 81.50 ms
sdb: 81.80 ms
sdb: 83.80 ms
sdb: 84.80 ms
sdb: 85.17 ms
sdb: 85.33 ms
sdb: 86.00 ms
sdb: 86.50 ms
sdb: 87.00 ms
sdb: 87.50 ms
sdb: 89.25 ms
sdb: 90.50 ms
sdb: 91.75 ms
sdb: 92.00 ms
sdb: 94.00 ms
sdb: 96.00 ms
sdb: 96.50 ms
sdb: 97.25 ms
sdb: 98.25 ms
sdb: 98.50 ms
sdb: 98.75 ms
sdc: 100.75 ms
sdc: 102.00 ms
sdc: 102.50 ms
sdc: 104.25 ms
sdc: 106.25 ms
sdc: 107.33 ms
sdc: 109.00 ms
sdc: 112.33 ms
sdc: 113.50 ms
sdc: 113.67 ms
sdc: 115.00 ms
sdc: 116.33 ms
sdc: 117.00 ms
sdc: 118.67 ms
sdc: 119.00 ms
sdc: 120.33 ms
sdc: 121.67 ms
sdc: 125.75 ms
sdc: 128.25 ms
sdc: 133.20 ms
sdc: 134.00 ms
sdc: 134.33 ms
sdc: 135.25 ms
sdc: 137.25 ms
sdc: 138.25 ms
sdc: 138.75 ms
sdc: 145.75 ms
sdc: 149.33 ms
sdc: 194.00 ms
sdc: 197.00 ms
sdc: 198.00 ms
sdc: 199.00 ms
sdc: 50.20 ms
sdc: 50.33 ms
sdc: 51.00 ms
sdc: 52.00 ms
sdc: 52.25 ms
sdc: 52.67 ms
sdc: 53.33 ms
sdc: 54.00 ms
sdc: 54.75 ms
sdc: 55.33 ms
sdc: 56.00 ms
sdc: 56.67 ms
sdc: 58.00 ms
sdc: 58.33 ms
sdc: 58.50 ms
sdc: 58.67 ms
sdc: 59.75 ms
sdc: 60.60 ms
sdc: 62.60 ms
sdc: 63.25 ms
sdc: 63.50 ms
sdc: 64.67 ms
sdc: 67.50 ms
sdc: 70.00 ms
sdc: 71.00 ms
sdc: 72.00 ms
sdc: 72.20 ms
sdc: 73.00 ms
sdc: 73.43 ms
sdc: 73.60 ms
sdc: 73.67 ms
sdc: 74.83 ms
sdc: 75.33 ms
sdc: 76.67 ms
sdc: 76.71 ms
sdc: 77.40 ms
sdc: 77.50 ms
sdc: 78.17 ms
sdc: 79.40 ms
sdc: 81.17 ms
sdc: 82.00 ms
sdc: 82.17 ms
sdc: 82.80 ms
sdc: 83.00 ms
sdc: 83.40 ms
sdc: 83.50 ms
sdc: 85.00 ms
sdc: 85.25 ms
sdc: 85.78 ms
sdc: 85.83 ms
sdc: 86.00 ms
sdc: 88.50 ms
sdc: 89.17 ms
sdc: 89.33 ms
sdc: 89.50 ms
sdc: 89.75 ms
sdc: 91.00 ms
sdc: 92.00 ms
sdc: 92.25 ms
sdc: 93.17 ms
sdc: 93.75 ms
sdc: 93.80 ms
sdc: 94.40 ms
sdc: 94.75 ms
sdc: 95.25 ms
sdc: 95.50 ms
sdc: 97.25 ms
sdc: 97.50 ms
sdc: 97.75 ms
sdc: 99.00 ms
sdc: 99.50 ms
sdc: 99.75 ms
sdd: 101.00 ms
sdd: 101.25 ms
sdd: 101.67 ms
sdd: 102.00 ms
sdd: 102.75 ms
sdd: 103.50 ms
sdd: 104.00 ms
sdd: 106.00 ms
sdd: 107.75 ms
sdd: 108.86 ms
sdd: 111.00 ms
sdd: 111.50 ms
sdd: 112.20 ms
sdd: 116.50 ms
sdd: 121.00 ms
sdd: 121.33 ms
sdd: 121.50 ms
sdd: 122.67 ms
sdd: 123.33 ms
sdd: 128.00 ms
sdd: 129.75 ms
sdd: 131.25 ms
sdd: 133.00 ms
sdd: 138.00 ms
sdd: 139.60 ms
sdd: 147.00 ms
sdd: 179.50 ms
sdd: 198.50 ms
sdd: 202.00 ms
sdd: 204.00 ms
sdd: 50.20 ms
sdd: 50.25 ms
sdd: 50.75 ms
sdd: 51.00 ms
sdd: 51.33 ms
sdd: 51.50 ms
sdd: 51.75 ms
sdd: 52.00 ms
sdd: 52.20 ms
sdd: 52.50 ms
sdd: 52.83 ms
sdd: 53.67 ms
sdd: 54.80 ms
sdd: 55.00 ms
sdd: 55.25 ms
sdd: 55.40 ms
sdd: 56.00 ms
sdd: 56.75 ms
sdd: 57.00 ms
sdd: 57.33 ms
sdd: 57.67 ms
sdd: 58.25 ms
sdd: 58.33 ms
sdd: 59.33 ms
sdd: 59.50 ms
sdd: 63.00 ms
sdd: 65.67 ms
sdd: 66.17 ms
sdd: 66.50 ms
sdd: 66.86 ms
sdd: 67.67 ms
sdd: 68.14 ms
sdd: 69.00 ms
sdd: 70.86 ms
sdd: 71.67 ms
sdd: 72.00 ms
sdd: 72.17 ms
sdd: 73.29 ms
sdd: 73.50 ms
sdd: 74.00 ms
sdd: 74.33 ms
sdd: 74.83 ms
sdd: 75.67 ms
sdd: 76.50 ms
sdd: 76.57 ms
sdd: 76.60 ms
sdd: 76.83 ms
sdd: 78.00 ms
sdd: 78.20 ms
sdd: 78.50 ms
sdd: 79.00 ms
sdd: 79.33 ms
sdd: 79.50 ms
sdd: 80.00 ms
sdd: 80.71 ms
sdd: 81.17 ms
sdd: 81.50 ms
sdd: 81.67 ms
sdd: 82.33 ms
sdd: 82.40 ms
sdd: 82.80 ms
sdd: 83.00 ms
sdd: 83.20 ms
sdd: 83.33 ms
sdd: 83.43 ms
sdd: 83.67 ms
sdd: 84.00 ms
sdd: 84.17 ms
sdd: 84.20 ms
sdd: 84.40 ms
sdd: 84.75 ms
sdd: 86.00 ms
sdd: 86.75 ms
sdd: 87.00 ms
sdd: 87.33 ms
sdd: 87.60 ms
sdd: 87.67 ms
sdd: 87.80 ms
sdd: 88.75 ms
sdd: 89.25 ms
sdd: 90.25 ms
sdd: 90.67 ms
sdd: 90.75 ms
sdd: 91.25 ms
sdd: 92.25 ms
sdd: 93.00 ms
sdd: 93.33 ms
sdd: 94.00 ms
sdd: 94.25 ms
sdd: 94.40 ms
sdd: 95.25 ms
sdd: 96.50 ms
sdd: 96.75 ms
sdd: 97.00 ms
sdd: 97.25 ms
sdd: 97.67 ms
sdd: 98.75 ms
sdd: 99.00 ms
sdd: 99.50 ms
sde: 100.00 ms
sde: 100.50 ms
sde: 100.75 ms
sde: 101.29 ms
sde: 101.50 ms
sde: 102.00 ms
sde: 102.80 ms
sde: 103.75 ms
sde: 104.25 ms
sde: 104.33 ms
sde: 104.50 ms
sde: 105.00 ms
sde: 107.00 ms
sde: 107.33 ms
sde: 116.00 ms
sde: 118.00 ms
sde: 118.50 ms
sde: 123.33 ms
sde: 124.17 ms
sde: 126.00 ms
sde: 132.00 ms
sde: 133.50 ms
sde: 134.50 ms
sde: 141.00 ms
sde: 143.00 ms
sde: 156.00 ms
sde: 157.00 ms
sde: 162.00 ms
sde: 177.00 ms
sde: 212.00 ms
sde: 50.67 ms
sde: 51.00 ms
sde: 51.25 ms
sde: 51.40 ms
sde: 52.20 ms
sde: 52.50 ms
sde: 52.75 ms
sde: 52.83 ms
sde: 53.12 ms
sde: 53.29 ms
sde: 53.50 ms
sde: 53.67 ms
sde: 53.75 ms
sde: 55.00 ms
sde: 55.88 ms
sde: 57.00 ms
sde: 57.33 ms
sde: 57.50 ms
sde: 58.00 ms
sde: 58.80 ms
sde: 59.33 ms
sde: 60.33 ms
sde: 62.00 ms
sde: 62.50 ms
sde: 64.62 ms
sde: 65.00 ms
sde: 65.50 ms
sde: 66.50 ms
sde: 66.80 ms
sde: 66.88 ms
sde: 68.33 ms
sde: 69.00 ms
sde: 70.33 ms
sde: 70.50 ms
sde: 71.00 ms
sde: 72.00 ms
sde: 72.12 ms
sde: 72.75 ms
sde: 73.67 ms
sde: 75.00 ms
sde: 76.00 ms
sde: 78.33 ms
sde: 78.50 ms
sde: 79.00 ms
sde: 79.20 ms
sde: 80.20 ms
sde: 80.80 ms
sde: 81.25 ms
sde: 81.29 ms
sde: 82.00 ms
sde: 83.20 ms
sde: 83.50 ms
sde: 84.33 ms
sde: 84.50 ms
sde: 84.83 ms
sde: 85.40 ms
sde: 85.75 ms
sde: 85.80 ms
sde: 86.80 ms
sde: 87.50 ms
sde: 89.00 ms
sde: 89.25 ms
sde: 90.50 ms
sde: 91.17 ms
sde: 91.67 ms
sde: 92.25 ms
sde: 92.75 ms
sde: 95.50 ms
sde: 95.75 ms
sde: 96.00 ms
sde: 96.50 ms
sde: 96.75 ms
sde: 97.25 ms
sde: 97.50 ms
sde: 99.00 ms
sdf: 100.00 ms
sdf: 100.25 ms
sdf: 101.00 ms
sdf: 101.50 ms
sdf: 101.75 ms
sdf: 102.00 ms
sdf: 103.00 ms
sdf: 103.67 ms
sdf: 105.25 ms
sdf: 106.50 ms
sdf: 107.50 ms
sdf: 108.67 ms
sdf: 110.00 ms
sdf: 110.71 ms
sdf: 111.33 ms
sdf: 113.00 ms
sdf: 114.00 ms
sdf: 114.67 ms
sdf: 117.33 ms
sdf: 117.50 ms
sdf: 117.67 ms
sdf: 118.00 ms
sdf: 119.00 ms
sdf: 119.33 ms
sdf: 121.00 ms
sdf: 121.33 ms
sdf: 122.33 ms
sdf: 122.67 ms
sdf: 126.00 ms
sdf: 129.33 ms
sdf: 130.33 ms
sdf: 131.25 ms
sdf: 150.25 ms
sdf: 213.00 ms
sdf: 50.33 ms
sdf: 50.50 ms
sdf: 50.80 ms
sdf: 50.83 ms
sdf: 51.00 ms
sdf: 51.33 ms
sdf: 51.50 ms
sdf: 51.60 ms
sdf: 51.75 ms
sdf: 52.50 ms
sdf: 53.25 ms
sdf: 54.00 ms
sdf: 54.33 ms
sdf: 54.67 ms
sdf: 56.00 ms
sdf: 56.33 ms
sdf: 57.75 ms
sdf: 61.00 ms
sdf: 61.33 ms
sdf: 61.86 ms
sdf: 63.20 ms
sdf: 63.33 ms
sdf: 63.50 ms
sdf: 64.00 ms
sdf: 64.29 ms
sdf: 65.00 ms
sdf: 65.67 ms
sdf: 66.33 ms
sdf: 67.00 ms
sdf: 69.56 ms
sdf: 71.00 ms
sdf: 72.67 ms
sdf: 73.00 ms
sdf: 74.86 ms
sdf: 75.60 ms
sdf: 75.67 ms
sdf: 75.83 ms
sdf: 76.25 ms
sdf: 78.00 ms
sdf: 78.60 ms
sdf: 79.50 ms
sdf: 81.20 ms
sdf: 82.20 ms
sdf: 82.25 ms
sdf: 82.50 ms
sdf: 82.60 ms
sdf: 83.25 ms
sdf: 83.33 ms
sdf: 84.50 ms
sdf: 84.60 ms
sdf: 85.00 ms
sdf: 85.17 ms
sdf: 85.40 ms
sdf: 86.67 ms
sdf: 86.83 ms
sdf: 87.40 ms
sdf: 87.50 ms
sdf: 88.17 ms
sdf: 88.75 ms
sdf: 89.00 ms
sdf: 89.25 ms
sdf: 90.00 ms
sdf: 91.50 ms
sdf: 91.60 ms
sdf: 92.00 ms
sdf: 93.25 ms
sdf: 94.00 ms
sdf: 94.25 ms
sdf: 95.17 ms
sdf: 95.25 ms
sdf: 96.50 ms
sdf: 97.00 ms
sdf: 97.50 ms
sdf: 98.50 ms
sdf: 99.00 ms
sdf: 99.25 ms
sdf: 99.75 ms
sdf: 99.80 ms
sdg: 100.50 ms
sdg: 100.75 ms
sdg: 101.25 ms
sdg: 101.50 ms
sdg: 101.75 ms
sdg: 102.50 ms
sdg: 103.00 ms
sdg: 103.25 ms
sdg: 103.50 ms
sdg: 104.25 ms
sdg: 104.50 ms
sdg: 105.00 ms
sdg: 106.00 ms
sdg: 106.50 ms
sdg: 108.00 ms
sdg: 109.00 ms
sdg: 110.00 ms
sdg: 111.00 ms
sdg: 112.25 ms
sdg: 118.00 ms
sdg: 119.00 ms
sdg: 119.67 ms
sdg: 121.00 ms
sdg: 121.67 ms
sdg: 122.33 ms
sdg: 124.67 ms
sdg: 126.00 ms
sdg: 132.00 ms
sdg: 138.67 ms
sdg: 146.60 ms
sdg: 161.00 ms
sdg: 193.00 ms
sdg: 225.00 ms
sdg: 50.25 ms
sdg: 50.33 ms
sdg: 50.67 ms
sdg: 51.00 ms
sdg: 51.25 ms
sdg: 51.33 ms
sdg: 51.38 ms
sdg: 51.50 ms
sdg: 52.00 ms
sdg: 52.25 ms
sdg: 52.33 ms
sdg: 53.20 ms
sdg: 53.50 ms
sdg: 53.75 ms
sdg: 53.80 ms
sdg: 54.17 ms
sdg: 54.83 ms
sdg: 55.00 ms
sdg: 55.25 ms
sdg: 55.50 ms
sdg: 56.40 ms
sdg: 58.67 ms
sdg: 60.67 ms
sdg: 61.00 ms
sdg: 61.67 ms
sdg: 61.86 ms
sdg: 62.00 ms
sdg: 62.25 ms
sdg: 62.71 ms
sdg: 63.00 ms
sdg: 64.25 ms
sdg: 64.33 ms
sdg: 64.43 ms
sdg: 64.67 ms
sdg: 67.67 ms
sdg: 67.75 ms
sdg: 69.50 ms
sdg: 69.67 ms
sdg: 69.83 ms
sdg: 70.29 ms
sdg: 70.33 ms
sdg: 71.00 ms
sdg: 72.67 ms
sdg: 72.80 ms
sdg: 73.00 ms
sdg: 73.33 ms
sdg: 75.00 ms
sdg: 78.00 ms
sdg: 78.20 ms
sdg: 78.67 ms
sdg: 80.00 ms
sdg: 80.20 ms
sdg: 80.33 ms
sdg: 82.20 ms
sdg: 82.50 ms
sdg: 82.60 ms
sdg: 82.80 ms
sdg: 83.00 ms
sdg: 83.33 ms
sdg: 85.75 ms
sdg: 86.20 ms
sdg: 86.83 ms
sdg: 91.33 ms
sdg: 92.33 ms
sdg: 92.50 ms
sdg: 93.25 ms
sdg: 94.50 ms
sdg: 96.00 ms
sdg: 97.00 ms
sdg: 97.75 ms
sdg: 98.00 ms
sdg: 98.25 ms
sdg: 98.50 ms
sdg: 99.00 ms
sdg: 99.25 ms
sdg: 99.75 ms
sdh: 100.00 ms
sdh: 102.25 ms
sdh: 103.50 ms
sdh: 105.43 ms
sdh: 108.00 ms
sdh: 112.60 ms
sdh: 112.75 ms
sdh: 116.00 ms
sdh: 117.00 ms
sdh: 120.00 ms
sdh: 120.33 ms
sdh: 124.67 ms
sdh: 127.00 ms
sdh: 128.67 ms
sdh: 131.00 ms
sdh: 132.67 ms
sdh: 137.40 ms
sdh: 140.00 ms
sdh: 158.00 ms
sdh: 167.00 ms
sdh: 173.00 ms
sdh: 50.50 ms
sdh: 50.75 ms
sdh: 50.80 ms
sdh: 51.25 ms
sdh: 51.40 ms
sdh: 51.50 ms
sdh: 52.00 ms
sdh: 52.17 ms
sdh: 52.33 ms
sdh: 52.75 ms
sdh: 53.00 ms
sdh: 53.50 ms
sdh: 53.75 ms
sdh: 54.00 ms
sdh: 55.00 ms
sdh: 55.17 ms
sdh: 55.25 ms
sdh: 56.00 ms
sdh: 56.33 ms
sdh: 57.50 ms
sdh: 57.67 ms
sdh: 58.50 ms
sdh: 58.86 ms
sdh: 60.00 ms
sdh: 61.25 ms
sdh: 61.33 ms
sdh: 61.50 ms
sdh: 61.67 ms
sdh: 62.67 ms
sdh: 63.14 ms
sdh: 63.50 ms
sdh: 64.00 ms
sdh: 65.11 ms
sdh: 65.33 ms
sdh: 65.83 ms
sdh: 67.43 ms
sdh: 68.14 ms
sdh: 69.75 ms
sdh: 71.40 ms
sdh: 71.67 ms
sdh: 72.00 ms
sdh: 73.00 ms
sdh: 75.33 ms
sdh: 76.60 ms
sdh: 76.71 ms
sdh: 76.83 ms
sdh: 77.88 ms
sdh: 78.20 ms
sdh: 79.67 ms
sdh: 80.40 ms
sdh: 80.50 ms
sdh: 81.60 ms
sdh: 81.67 ms
sdh: 82.60 ms
sdh: 82.67 ms
sdh: 82.80 ms
sdh: 83.75 ms
sdh: 83.83 ms
sdh: 84.00 ms
sdh: 85.17 ms
sdh: 85.29 ms
sdh: 86.00 ms
sdh: 86.33 ms
sdh: 86.50 ms
sdh: 87.25 ms
sdh: 87.67 ms
sdh: 88.17 ms
sdh: 89.50 ms
sdh: 89.75 ms
sdh: 90.25 ms
sdh: 90.88 ms
sdh: 91.50 ms
sdh: 91.60 ms
sdh: 91.67 ms
sdh: 92.50 ms
sdh: 92.75 ms
sdh: 92.83 ms
sdh: 93.00 ms
sdh: 93.25 ms
sdh: 94.00 ms
sdh: 94.50 ms
sdh: 94.75 ms
sdh: 95.33 ms
sdh: 95.43 ms
sdh: 95.50 ms
sdh: 95.75 ms
sdh: 96.25 ms
sdh: 99.25 ms
sdi: 101.50 ms
sdi: 101.75 ms
sdi: 102.00 ms
sdi: 104.00 ms
sdi: 104.75 ms
sdi: 105.40 ms
sdi: 106.00 ms
sdi: 107.00 ms
sdi: 109.00 ms
sdi: 112.33 ms
sdi: 113.00 ms
sdi: 113.33 ms
sdi: 114.00 ms
sdi: 115.67 ms
sdi: 116.33 ms
sdi: 117.00 ms
sdi: 117.67 ms
sdi: 118.33 ms
sdi: 119.33 ms
sdi: 120.00 ms
sdi: 125.67 ms
sdi: 126.67 ms
sdi: 128.67 ms
sdi: 130.00 ms
sdi: 131.00 ms
sdi: 132.67 ms
sdi: 134.00 ms
sdi: 150.75 ms
sdi: 172.00 ms
sdi: 179.00 ms
sdi: 209.00 ms
sdi: 50.75 ms
sdi: 51.00 ms
sdi: 51.67 ms
sdi: 51.80 ms
sdi: 52.50 ms
sdi: 52.60 ms
sdi: 54.00 ms
sdi: 54.33 ms
sdi: 55.00 ms
sdi: 55.50 ms
sdi: 58.00 ms
sdi: 58.25 ms
sdi: 58.67 ms
sdi: 59.17 ms
sdi: 59.67 ms
sdi: 60.75 ms
sdi: 62.75 ms
sdi: 65.50 ms
sdi: 66.50 ms
sdi: 66.67 ms
sdi: 67.00 ms
sdi: 67.33 ms
sdi: 67.50 ms
sdi: 69.20 ms
sdi: 71.00 ms
sdi: 72.00 ms
sdi: 73.00 ms
sdi: 75.67 ms
sdi: 76.33 ms
sdi: 79.17 ms
sdi: 79.20 ms
sdi: 79.75 ms
sdi: 81.00 ms
sdi: 82.20 ms
sdi: 83.00 ms
sdi: 84.00 ms
sdi: 84.75 ms
sdi: 85.17 ms
sdi: 85.75 ms
sdi: 86.25 ms
sdi: 86.50 ms
sdi: 87.50 ms
sdi: 88.67 ms
sdi: 89.50 ms
sdi: 91.25 ms
sdi: 93.00 ms
sdi: 94.25 ms
sdi: 94.50 ms
sdi: 94.75 ms
sdi: 95.50 ms
sdi: 95.75 ms
sdi: 96.00 ms
sdi: 97.25 ms
sdi: 97.50 ms
sdi: 99.25 ms
sdj: 100.25 ms
sdj: 100.50 ms
sdj: 100.67 ms
sdj: 101.20 ms
sdj: 103.50 ms
sdj: 104.00 ms
sdj: 104.50 ms
sdj: 107.00 ms
sdj: 109.00 ms
sdj: 110.33 ms
sdj: 111.83 ms
sdj: 113.17 ms
sdj: 114.00 ms
sdj: 115.67 ms
sdj: 118.40 ms
sdj: 120.00 ms
sdj: 120.33 ms
sdj: 120.83 ms
sdj: 121.00 ms
sdj: 121.50 ms
sdj: 122.67 ms
sdj: 123.67 ms
sdj: 126.67 ms
sdj: 128.67 ms
sdj: 134.00 ms
sdj: 135.00 ms
sdj: 139.00 ms
sdj: 139.25 ms
sdj: 148.00 ms
sdj: 159.00 ms
sdj: 165.00 ms
sdj: 50.25 ms
sdj: 50.50 ms
sdj: 50.75 ms
sdj: 51.00 ms
sdj: 51.33 ms
sdj: 52.00 ms
sdj: 52.25 ms
sdj: 52.50 ms
sdj: 53.00 ms
sdj: 53.14 ms
sdj: 53.33 ms
sdj: 53.50 ms
sdj: 53.83 ms
sdj: 54.83 ms
sdj: 55.67 ms
sdj: 56.20 ms
sdj: 56.33 ms
sdj: 59.25 ms
sdj: 60.33 ms
sdj: 62.20 ms
sdj: 62.83 ms
sdj: 63.00 ms
sdj: 63.86 ms
sdj: 64.00 ms
sdj: 64.14 ms
sdj: 65.00 ms
sdj: 67.67 ms
sdj: 69.17 ms
sdj: 69.50 ms
sdj: 70.25 ms
sdj: 70.67 ms
sdj: 71.33 ms
sdj: 72.88 ms
sdj: 74.80 ms
sdj: 75.60 ms
sdj: 75.83 ms
sdj: 76.22 ms
sdj: 76.80 ms
sdj: 77.33 ms
sdj: 78.17 ms
sdj: 79.20 ms
sdj: 80.75 ms
sdj: 80.83 ms
sdj: 81.25 ms
sdj: 82.50 ms
sdj: 82.83 ms
sdj: 83.20 ms
sdj: 83.80 ms
sdj: 84.00 ms
sdj: 85.00 ms
sdj: 86.40 ms
sdj: 86.50 ms
sdj: 86.75 ms
sdj: 87.00 ms
sdj: 88.17 ms
sdj: 88.50 ms
sdj: 89.00 ms
sdj: 89.57 ms
sdj: 90.00 ms
sdj: 90.25 ms
sdj: 91.67 ms
sdj: 92.00 ms
sdj: 94.00 ms
sdj: 95.00 ms
sdj: 96.75 ms
sdj: 97.75 ms
sdj: 98.00 ms
sdk: 100.50 ms
sdk: 102.50 ms
sdk: 103.00 ms
sdk: 104.00 ms
sdk: 104.25 ms
sdk: 107.00 ms
sdk: 108.50 ms
sdk: 110.50 ms
sdk: 111.67 ms
sdk: 113.00 ms
sdk: 114.00 ms
sdk: 116.33 ms
sdk: 117.67 ms
sdk: 118.25 ms
sdk: 119.33 ms
sdk: 119.83 ms
sdk: 120.00 ms
sdk: 121.00 ms
sdk: 122.67 ms
sdk: 123.00 ms
sdk: 126.00 ms
sdk: 129.00 ms
sdk: 129.75 ms
sdk: 135.67 ms
sdk: 140.50 ms
sdk: 141.25 ms
sdk: 178.00 ms
sdk: 50.20 ms
sdk: 50.33 ms
sdk: 50.67 ms
sdk: 51.00 ms
sdk: 51.17 ms
sdk: 52.75 ms
sdk: 53.20 ms
sdk: 53.50 ms
sdk: 54.67 ms
sdk: 54.83 ms
sdk: 55.00 ms
sdk: 55.67 ms
sdk: 56.00 ms
sdk: 57.00 ms
sdk: 58.00 ms
sdk: 59.00 ms
sdk: 60.00 ms
sdk: 61.50 ms
sdk: 63.71 ms
sdk: 63.80 ms
sdk: 64.00 ms
sdk: 65.00 ms
sdk: 67.67 ms
sdk: 68.50 ms
sdk: 68.67 ms
sdk: 68.80 ms
sdk: 69.75 ms
sdk: 70.40 ms
sdk: 73.83 ms
sdk: 77.00 ms
sdk: 79.00 ms
sdk: 80.71 ms
sdk: 81.00 ms
sdk: 81.67 ms
sdk: 82.00 ms
sdk: 83.33 ms
sdk: 83.60 ms
sdk: 83.83 ms
sdk: 84.00 ms
sdk: 84.83 ms
sdk: 86.00 ms
sdk: 86.20 ms
sdk: 86.25 ms
sdk: 87.33 ms
sdk: 88.25 ms
sdk: 89.50 ms
sdk: 90.75 ms
sdk: 91.60 ms
sdk: 93.25 ms
sdk: 94.25 ms
sdk: 94.75 ms
sdk: 94.80 ms
sdk: 95.75 ms
sdk: 96.00 ms
sdk: 97.25 ms
sdk: 99.25 ms
sdk: 99.60 ms
sdl: 100.25 ms
sdl: 100.50 ms
sdl: 101.00 ms
sdl: 101.50 ms
sdl: 103.25 ms
sdl: 103.50 ms
sdl: 103.75 ms
sdl: 104.00 ms
sdl: 106.00 ms
sdl: 107.50 ms
sdl: 110.00 ms
sdl: 113.00 ms
sdl: 113.50 ms
sdl: 114.00 ms
sdl: 115.50 ms
sdl: 116.00 ms
sdl: 121.33 ms
sdl: 122.33 ms
sdl: 123.33 ms
sdl: 127.33 ms
sdl: 128.67 ms
sdl: 131.00 ms
sdl: 137.75 ms
sdl: 158.00 ms
sdl: 168.00 ms
sdl: 174.00 ms
sdl: 182.00 ms
sdl: 50.29 ms
sdl: 50.75 ms
sdl: 51.00 ms
sdl: 51.17 ms
sdl: 51.20 ms
sdl: 51.33 ms
sdl: 52.00 ms
sdl: 52.17 ms
sdl: 52.50 ms
sdl: 52.67 ms
sdl: 52.75 ms
sdl: 53.00 ms
sdl: 53.33 ms
sdl: 53.50 ms
sdl: 54.00 ms
sdl: 54.50 ms
sdl: 54.67 ms
sdl: 55.00 ms
sdl: 55.67 ms
sdl: 56.25 ms
sdl: 56.50 ms
sdl: 57.00 ms
sdl: 57.40 ms
sdl: 57.67 ms
sdl: 58.00 ms
sdl: 58.67 ms
sdl: 58.75 ms
sdl: 58.83 ms
sdl: 59.67 ms
sdl: 60.50 ms
sdl: 60.80 ms
sdl: 62.00 ms
sdl: 64.75 ms
sdl: 67.00 ms
sdl: 68.33 ms
sdl: 70.00 ms
sdl: 70.33 ms
sdl: 71.33 ms
sdl: 71.83 ms
sdl: 73.33 ms
sdl: 75.67 ms
sdl: 76.67 ms
sdl: 77.00 ms
sdl: 77.83 ms
sdl: 78.83 ms
sdl: 79.60 ms
sdl: 79.75 ms
sdl: 80.67 ms
sdl: 81.50 ms
sdl: 82.33 ms
sdl: 83.00 ms
sdl: 83.17 ms
sdl: 84.40 ms
sdl: 84.80 ms
sdl: 87.50 ms
sdl: 88.50 ms
sdl: 88.88 ms
sdl: 89.25 ms
sdl: 90.00 ms
sdl: 90.83 ms
sdl: 93.50 ms
sdl: 94.00 ms
sdl: 94.25 ms
sdl: 94.75 ms
sdl: 95.25 ms
sdl: 95.50 ms
sdl: 96.20 ms
sdl: 97.00 ms
sdl: 97.25 ms
sdl: 98.25 ms
sdl: 98.50 ms
sdl: 99.25 ms
sdl: 99.50 ms
```

---

### 网络问题分析

⚠ **检测到网络问题**

**重传统计：**
    44494 segments retransmitted
    30536 fast retransmits
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

