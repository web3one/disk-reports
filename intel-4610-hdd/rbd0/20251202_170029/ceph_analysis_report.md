# Ceph 性能瓶颈分析报告

**分析时间**: 2025-12-02 17:08:03
**监控数据目录**: /home/ubuntu/intel-4610-hdd/rbd0/20251202_170029/ceph-monitoring

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
rbd0: 100.20%
rbd0: 90.10%
rbd0: 90.40%
rbd0: 90.50%
rbd0: 90.70%
rbd0: 91.00%
rbd0: 91.10%
rbd0: 91.20%
rbd0: 91.50%
rbd0: 92.20%
rbd0: 92.50%
rbd0: 92.70%
rbd0: 94.90%
rbd0: 95.00%
rbd0: 95.20%
rbd0: 95.40%
rbd0: 95.60%
rbd0: 95.70%
rbd0: 95.80%
rbd0: 96.00%
rbd0: 96.10%
rbd0: 96.20%
rbd0: 96.30%
rbd0: 96.40%
rbd0: 96.50%
rbd0: 96.60%
rbd0: 96.70%
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
rbd0: 98.30%
rbd0: 98.40%
rbd0: 98.50%
rbd0: 98.60%
rbd0: 98.70%
rbd0: 98.80%
rbd0: 99.00%
rbd0: 99.01%
rbd0: 99.10%
rbd0: 99.80%
rbd0: 99.90%
```

**建议**: 高利用率磁盘可能成为瓶颈，检查是否为慢盘或负载不均。

**⚠ 检测到高延迟磁盘（await > 50ms）：**
```
sda: 101.00 ms
sda: 102.33 ms
sda: 102.50 ms
sda: 103.25 ms
sda: 103.75 ms
sda: 105.50 ms
sda: 106.00 ms
sda: 109.33 ms
sda: 109.50 ms
sda: 111.00 ms
sda: 112.50 ms
sda: 114.43 ms
sda: 115.00 ms
sda: 115.33 ms
sda: 116.33 ms
sda: 118.25 ms
sda: 119.50 ms
sda: 120.50 ms
sda: 120.67 ms
sda: 123.00 ms
sda: 123.17 ms
sda: 126.00 ms
sda: 131.75 ms
sda: 139.00 ms
sda: 219.00 ms
sda: 50.25 ms
sda: 50.50 ms
sda: 50.67 ms
sda: 50.75 ms
sda: 51.25 ms
sda: 51.33 ms
sda: 51.67 ms
sda: 51.75 ms
sda: 52.80 ms
sda: 52.83 ms
sda: 53.00 ms
sda: 53.33 ms
sda: 53.67 ms
sda: 54.00 ms
sda: 54.20 ms
sda: 55.86 ms
sda: 56.20 ms
sda: 56.67 ms
sda: 56.75 ms
sda: 57.00 ms
sda: 57.17 ms
sda: 57.80 ms
sda: 58.43 ms
sda: 60.00 ms
sda: 60.33 ms
sda: 60.75 ms
sda: 61.50 ms
sda: 61.83 ms
sda: 62.12 ms
sda: 62.14 ms
sda: 62.29 ms
sda: 62.67 ms
sda: 63.75 ms
sda: 64.00 ms
sda: 64.50 ms
sda: 65.00 ms
sda: 66.33 ms
sda: 66.67 ms
sda: 67.62 ms
sda: 68.20 ms
sda: 68.75 ms
sda: 69.50 ms
sda: 70.67 ms
sda: 71.62 ms
sda: 72.83 ms
sda: 74.33 ms
sda: 75.25 ms
sda: 75.40 ms
sda: 77.29 ms
sda: 78.00 ms
sda: 78.25 ms
sda: 78.40 ms
sda: 80.67 ms
sda: 81.33 ms
sda: 82.17 ms
sda: 83.00 ms
sda: 85.25 ms
sda: 85.33 ms
sda: 85.50 ms
sda: 86.00 ms
sda: 86.50 ms
sda: 87.00 ms
sda: 88.00 ms
sda: 88.75 ms
sda: 89.33 ms
sda: 90.00 ms
sda: 90.75 ms
sda: 91.50 ms
sda: 92.50 ms
sda: 93.50 ms
sda: 94.25 ms
sda: 95.50 ms
sda: 96.00 ms
sda: 96.50 ms
sda: 97.25 ms
sda: 97.50 ms
sda: 98.00 ms
sda: 98.50 ms
sda: 99.00 ms
sda: 99.25 ms
sdb: 101.00 ms
sdb: 102.50 ms
sdb: 103.00 ms
sdb: 103.20 ms
sdb: 104.25 ms
sdb: 104.33 ms
sdb: 105.50 ms
sdb: 106.00 ms
sdb: 107.25 ms
sdb: 108.00 ms
sdb: 110.83 ms
sdb: 111.50 ms
sdb: 114.00 ms
sdb: 115.67 ms
sdb: 116.00 ms
sdb: 118.00 ms
sdb: 118.83 ms
sdb: 119.00 ms
sdb: 119.33 ms
sdb: 122.50 ms
sdb: 123.00 ms
sdb: 124.50 ms
sdb: 127.50 ms
sdb: 130.33 ms
sdb: 130.75 ms
sdb: 133.25 ms
sdb: 143.00 ms
sdb: 144.75 ms
sdb: 147.50 ms
sdb: 153.00 ms
sdb: 176.00 ms
sdb: 209.00 ms
sdb: 50.50 ms
sdb: 51.33 ms
sdb: 52.00 ms
sdb: 52.67 ms
sdb: 53.60 ms
sdb: 53.67 ms
sdb: 54.00 ms
sdb: 55.67 ms
sdb: 56.00 ms
sdb: 56.50 ms
sdb: 56.75 ms
sdb: 56.83 ms
sdb: 57.00 ms
sdb: 59.33 ms
sdb: 59.67 ms
sdb: 60.17 ms
sdb: 61.67 ms
sdb: 61.86 ms
sdb: 63.00 ms
sdb: 63.60 ms
sdb: 63.67 ms
sdb: 63.80 ms
sdb: 64.50 ms
sdb: 65.50 ms
sdb: 66.43 ms
sdb: 66.57 ms
sdb: 67.17 ms
sdb: 67.75 ms
sdb: 69.00 ms
sdb: 72.00 ms
sdb: 72.29 ms
sdb: 73.00 ms
sdb: 73.33 ms
sdb: 73.50 ms
sdb: 73.67 ms
sdb: 74.67 ms
sdb: 75.17 ms
sdb: 75.33 ms
sdb: 75.83 ms
sdb: 76.40 ms
sdb: 76.50 ms
sdb: 76.67 ms
sdb: 78.17 ms
sdb: 78.50 ms
sdb: 78.60 ms
sdb: 78.67 ms
sdb: 79.14 ms
sdb: 80.00 ms
sdb: 80.20 ms
sdb: 80.33 ms
sdb: 80.80 ms
sdb: 82.17 ms
sdb: 83.20 ms
sdb: 83.50 ms
sdb: 83.80 ms
sdb: 85.50 ms
sdb: 87.20 ms
sdb: 87.83 ms
sdb: 88.00 ms
sdb: 88.17 ms
sdb: 90.00 ms
sdb: 90.75 ms
sdb: 91.33 ms
sdb: 91.50 ms
sdb: 91.83 ms
sdb: 92.00 ms
sdb: 92.75 ms
sdb: 93.00 ms
sdb: 93.25 ms
sdb: 94.25 ms
sdb: 94.50 ms
sdb: 95.25 ms
sdb: 97.00 ms
sdb: 97.75 ms
sdb: 98.00 ms
sdb: 98.50 ms
sdb: 98.60 ms
sdb: 99.25 ms
sdc: 100.25 ms
sdc: 102.20 ms
sdc: 102.50 ms
sdc: 103.80 ms
sdc: 105.50 ms
sdc: 108.83 ms
sdc: 110.00 ms
sdc: 112.00 ms
sdc: 112.33 ms
sdc: 113.00 ms
sdc: 114.67 ms
sdc: 116.50 ms
sdc: 117.00 ms
sdc: 117.50 ms
sdc: 118.00 ms
sdc: 120.67 ms
sdc: 121.33 ms
sdc: 122.00 ms
sdc: 125.00 ms
sdc: 131.25 ms
sdc: 133.25 ms
sdc: 150.00 ms
sdc: 164.00 ms
sdc: 200.00 ms
sdc: 50.25 ms
sdc: 51.00 ms
sdc: 51.80 ms
sdc: 52.67 ms
sdc: 54.00 ms
sdc: 54.17 ms
sdc: 55.40 ms
sdc: 56.60 ms
sdc: 56.75 ms
sdc: 57.40 ms
sdc: 59.38 ms
sdc: 60.12 ms
sdc: 60.20 ms
sdc: 60.67 ms
sdc: 62.14 ms
sdc: 62.67 ms
sdc: 63.33 ms
sdc: 63.50 ms
sdc: 65.67 ms
sdc: 66.80 ms
sdc: 67.00 ms
sdc: 67.50 ms
sdc: 67.71 ms
sdc: 67.83 ms
sdc: 69.00 ms
sdc: 69.83 ms
sdc: 70.40 ms
sdc: 72.43 ms
sdc: 72.50 ms
sdc: 72.83 ms
sdc: 73.00 ms
sdc: 73.33 ms
sdc: 73.60 ms
sdc: 74.17 ms
sdc: 74.20 ms
sdc: 74.25 ms
sdc: 75.40 ms
sdc: 75.67 ms
sdc: 77.00 ms
sdc: 77.50 ms
sdc: 77.67 ms
sdc: 79.33 ms
sdc: 79.50 ms
sdc: 79.83 ms
sdc: 80.40 ms
sdc: 84.33 ms
sdc: 84.50 ms
sdc: 84.67 ms
sdc: 85.25 ms
sdc: 85.60 ms
sdc: 85.83 ms
sdc: 86.50 ms
sdc: 86.80 ms
sdc: 87.17 ms
sdc: 87.67 ms
sdc: 87.75 ms
sdc: 88.50 ms
sdc: 88.75 ms
sdc: 89.50 ms
sdc: 89.75 ms
sdc: 90.25 ms
sdc: 90.50 ms
sdc: 90.67 ms
sdc: 91.50 ms
sdc: 91.75 ms
sdc: 92.75 ms
sdc: 93.25 ms
sdc: 93.75 ms
sdc: 94.25 ms
sdc: 94.50 ms
sdc: 96.00 ms
sdc: 96.50 ms
sdc: 97.00 ms
sdc: 97.50 ms
sdc: 97.75 ms
sdc: 98.00 ms
sdc: 98.25 ms
sdc: 99.00 ms
sdc: 99.75 ms
sdd: 100.00 ms
sdd: 100.50 ms
sdd: 101.00 ms
sdd: 102.75 ms
sdd: 103.00 ms
sdd: 104.00 ms
sdd: 104.75 ms
sdd: 105.25 ms
sdd: 105.75 ms
sdd: 106.83 ms
sdd: 108.00 ms
sdd: 109.00 ms
sdd: 109.33 ms
sdd: 109.67 ms
sdd: 110.33 ms
sdd: 111.75 ms
sdd: 112.67 ms
sdd: 113.67 ms
sdd: 114.00 ms
sdd: 118.67 ms
sdd: 119.67 ms
sdd: 120.67 ms
sdd: 122.83 ms
sdd: 123.83 ms
sdd: 124.75 ms
sdd: 126.00 ms
sdd: 136.67 ms
sdd: 138.75 ms
sdd: 146.00 ms
sdd: 153.00 ms
sdd: 216.00 ms
sdd: 50.20 ms
sdd: 50.25 ms
sdd: 50.40 ms
sdd: 50.50 ms
sdd: 51.00 ms
sdd: 51.50 ms
sdd: 53.00 ms
sdd: 53.75 ms
sdd: 54.50 ms
sdd: 54.75 ms
sdd: 55.33 ms
sdd: 55.67 ms
sdd: 56.50 ms
sdd: 56.67 ms
sdd: 57.00 ms
sdd: 57.67 ms
sdd: 58.00 ms
sdd: 58.17 ms
sdd: 58.33 ms
sdd: 61.00 ms
sdd: 61.50 ms
sdd: 62.29 ms
sdd: 62.40 ms
sdd: 62.75 ms
sdd: 63.33 ms
sdd: 64.00 ms
sdd: 65.00 ms
sdd: 66.00 ms
sdd: 67.00 ms
sdd: 67.67 ms
sdd: 68.20 ms
sdd: 69.00 ms
sdd: 69.17 ms
sdd: 70.50 ms
sdd: 73.75 ms
sdd: 73.80 ms
sdd: 74.25 ms
sdd: 74.67 ms
sdd: 75.33 ms
sdd: 75.83 ms
sdd: 76.20 ms
sdd: 76.50 ms
sdd: 77.67 ms
sdd: 78.00 ms
sdd: 78.50 ms
sdd: 79.20 ms
sdd: 79.67 ms
sdd: 79.80 ms
sdd: 80.20 ms
sdd: 80.67 ms
sdd: 81.00 ms
sdd: 82.80 ms
sdd: 83.40 ms
sdd: 83.60 ms
sdd: 83.75 ms
sdd: 84.50 ms
sdd: 85.62 ms
sdd: 85.67 ms
sdd: 85.75 ms
sdd: 86.60 ms
sdd: 88.50 ms
sdd: 89.60 ms
sdd: 90.25 ms
sdd: 91.00 ms
sdd: 91.33 ms
sdd: 91.75 ms
sdd: 92.75 ms
sdd: 93.00 ms
sdd: 93.25 ms
sdd: 93.33 ms
sdd: 93.62 ms
sdd: 94.25 ms
sdd: 95.22 ms
sdd: 95.50 ms
sdd: 95.75 ms
sdd: 96.00 ms
sdd: 96.17 ms
sdd: 96.50 ms
sdd: 97.00 ms
sdd: 97.25 ms
sdd: 98.00 ms
sdd: 98.40 ms
sdd: 98.67 ms
sde: 100.00 ms
sde: 101.00 ms
sde: 101.43 ms
sde: 103.50 ms
sde: 104.40 ms
sde: 104.50 ms
sde: 105.00 ms
sde: 110.00 ms
sde: 112.50 ms
sde: 117.00 ms
sde: 119.33 ms
sde: 119.67 ms
sde: 120.00 ms
sde: 121.00 ms
sde: 121.75 ms
sde: 121.80 ms
sde: 122.00 ms
sde: 128.33 ms
sde: 135.75 ms
sde: 138.00 ms
sde: 140.00 ms
sde: 145.50 ms
sde: 146.25 ms
sde: 148.75 ms
sde: 161.00 ms
sde: 166.00 ms
sde: 199.00 ms
sde: 211.00 ms
sde: 50.25 ms
sde: 50.40 ms
sde: 50.50 ms
sde: 50.67 ms
sde: 50.75 ms
sde: 51.25 ms
sde: 51.33 ms
sde: 51.60 ms
sde: 52.17 ms
sde: 53.67 ms
sde: 53.83 ms
sde: 54.67 ms
sde: 55.33 ms
sde: 55.50 ms
sde: 55.75 ms
sde: 56.75 ms
sde: 57.33 ms
sde: 59.50 ms
sde: 60.33 ms
sde: 61.00 ms
sde: 62.33 ms
sde: 65.33 ms
sde: 66.33 ms
sde: 67.00 ms
sde: 68.22 ms
sde: 69.00 ms
sde: 69.67 ms
sde: 70.00 ms
sde: 70.17 ms
sde: 71.60 ms
sde: 72.00 ms
sde: 72.50 ms
sde: 75.80 ms
sde: 75.83 ms
sde: 76.00 ms
sde: 76.17 ms
sde: 78.00 ms
sde: 78.70 ms
sde: 78.83 ms
sde: 79.17 ms
sde: 79.33 ms
sde: 79.50 ms
sde: 79.67 ms
sde: 80.00 ms
sde: 80.50 ms
sde: 80.83 ms
sde: 81.80 ms
sde: 82.00 ms
sde: 83.20 ms
sde: 83.67 ms
sde: 84.25 ms
sde: 84.67 ms
sde: 85.50 ms
sde: 86.67 ms
sde: 86.75 ms
sde: 88.00 ms
sde: 89.50 ms
sde: 90.00 ms
sde: 90.25 ms
sde: 90.75 ms
sde: 92.00 ms
sde: 92.25 ms
sde: 92.50 ms
sde: 93.50 ms
sde: 93.83 ms
sde: 94.00 ms
sde: 94.50 ms
sde: 95.00 ms
sde: 95.20 ms
sde: 95.50 ms
sde: 95.75 ms
sde: 96.75 ms
sde: 97.50 ms
sde: 97.80 ms
sde: 98.00 ms
sde: 98.50 ms
sde: 99.25 ms
sde: 99.50 ms
sde: 99.67 ms
sdf: 100.25 ms
sdf: 102.25 ms
sdf: 102.67 ms
sdf: 102.71 ms
sdf: 106.75 ms
sdf: 107.00 ms
sdf: 107.75 ms
sdf: 108.00 ms
sdf: 110.00 ms
sdf: 110.33 ms
sdf: 113.33 ms
sdf: 113.50 ms
sdf: 114.67 ms
sdf: 115.83 ms
sdf: 116.33 ms
sdf: 116.67 ms
sdf: 117.00 ms
sdf: 119.67 ms
sdf: 120.33 ms
sdf: 120.67 ms
sdf: 121.67 ms
sdf: 122.33 ms
sdf: 124.00 ms
sdf: 124.33 ms
sdf: 127.00 ms
sdf: 128.50 ms
sdf: 129.00 ms
sdf: 129.33 ms
sdf: 130.00 ms
sdf: 132.25 ms
sdf: 138.00 ms
sdf: 141.75 ms
sdf: 172.00 ms
sdf: 177.00 ms
sdf: 202.00 ms
sdf: 224.00 ms
sdf: 50.20 ms
sdf: 50.67 ms
sdf: 51.17 ms
sdf: 51.50 ms
sdf: 51.67 ms
sdf: 52.00 ms
sdf: 52.25 ms
sdf: 52.60 ms
sdf: 52.67 ms
sdf: 53.50 ms
sdf: 54.00 ms
sdf: 54.33 ms
sdf: 56.00 ms
sdf: 56.33 ms
sdf: 56.88 ms
sdf: 57.00 ms
sdf: 57.25 ms
sdf: 57.29 ms
sdf: 57.67 ms
sdf: 57.83 ms
sdf: 58.00 ms
sdf: 58.50 ms
sdf: 59.00 ms
sdf: 59.67 ms
sdf: 59.86 ms
sdf: 61.00 ms
sdf: 61.33 ms
sdf: 62.80 ms
sdf: 63.33 ms
sdf: 64.50 ms
sdf: 67.00 ms
sdf: 67.67 ms
sdf: 70.00 ms
sdf: 70.33 ms
sdf: 71.00 ms
sdf: 71.60 ms
sdf: 73.17 ms
sdf: 73.20 ms
sdf: 73.25 ms
sdf: 74.67 ms
sdf: 76.20 ms
sdf: 77.50 ms
sdf: 77.83 ms
sdf: 78.67 ms
sdf: 79.00 ms
sdf: 79.50 ms
sdf: 80.00 ms
sdf: 81.80 ms
sdf: 82.20 ms
sdf: 83.17 ms
sdf: 83.80 ms
sdf: 84.20 ms
sdf: 84.40 ms
sdf: 85.20 ms
sdf: 85.60 ms
sdf: 85.83 ms
sdf: 86.33 ms
sdf: 86.75 ms
sdf: 87.00 ms
sdf: 87.25 ms
sdf: 87.50 ms
sdf: 87.83 ms
sdf: 88.33 ms
sdf: 88.67 ms
sdf: 89.00 ms
sdf: 89.75 ms
sdf: 90.50 ms
sdf: 91.25 ms
sdf: 93.50 ms
sdf: 94.50 ms
sdf: 94.75 ms
sdf: 96.00 ms
sdf: 96.50 ms
sdf: 97.00 ms
sdf: 98.50 ms
sdf: 99.50 ms
sdg: 100.25 ms
sdg: 101.50 ms
sdg: 102.25 ms
sdg: 102.67 ms
sdg: 103.75 ms
sdg: 104.50 ms
sdg: 105.00 ms
sdg: 105.20 ms
sdg: 105.50 ms
sdg: 107.00 ms
sdg: 111.00 ms
sdg: 111.67 ms
sdg: 112.00 ms
sdg: 112.20 ms
sdg: 113.00 ms
sdg: 113.50 ms
sdg: 117.14 ms
sdg: 119.40 ms
sdg: 120.00 ms
sdg: 126.67 ms
sdg: 127.75 ms
sdg: 128.00 ms
sdg: 132.75 ms
sdg: 136.60 ms
sdg: 136.75 ms
sdg: 138.00 ms
sdg: 149.00 ms
sdg: 168.00 ms
sdg: 50.17 ms
sdg: 50.33 ms
sdg: 50.75 ms
sdg: 50.80 ms
sdg: 51.25 ms
sdg: 51.40 ms
sdg: 52.33 ms
sdg: 52.50 ms
sdg: 52.83 ms
sdg: 53.00 ms
sdg: 53.50 ms
sdg: 53.67 ms
sdg: 53.80 ms
sdg: 54.33 ms
sdg: 55.00 ms
sdg: 55.67 ms
sdg: 56.62 ms
sdg: 66.00 ms
sdg: 67.00 ms
sdg: 67.17 ms
sdg: 68.00 ms
sdg: 68.88 ms
sdg: 69.25 ms
sdg: 71.80 ms
sdg: 72.17 ms
sdg: 72.57 ms
sdg: 73.00 ms
sdg: 73.17 ms
sdg: 74.33 ms
sdg: 74.50 ms
sdg: 75.20 ms
sdg: 76.50 ms
sdg: 77.17 ms
sdg: 77.40 ms
sdg: 78.00 ms
sdg: 79.20 ms
sdg: 80.33 ms
sdg: 80.60 ms
sdg: 80.67 ms
sdg: 81.00 ms
sdg: 81.25 ms
sdg: 81.50 ms
sdg: 84.75 ms
sdg: 85.12 ms
sdg: 85.17 ms
sdg: 86.00 ms
sdg: 86.33 ms
sdg: 87.50 ms
sdg: 88.00 ms
sdg: 88.83 ms
sdg: 89.25 ms
sdg: 89.50 ms
sdg: 89.75 ms
sdg: 91.00 ms
sdg: 92.17 ms
sdg: 92.75 ms
sdg: 93.25 ms
sdg: 93.75 ms
sdg: 95.25 ms
sdg: 95.50 ms
sdg: 95.75 ms
sdg: 97.25 ms
sdg: 97.75 ms
sdg: 98.25 ms
sdh: 100.25 ms
sdh: 100.67 ms
sdh: 101.00 ms
sdh: 103.86 ms
sdh: 104.25 ms
sdh: 105.00 ms
sdh: 109.40 ms
sdh: 109.67 ms
sdh: 109.75 ms
sdh: 116.33 ms
sdh: 117.00 ms
sdh: 120.33 ms
sdh: 120.67 ms
sdh: 122.00 ms
sdh: 127.67 ms
sdh: 129.67 ms
sdh: 130.00 ms
sdh: 136.75 ms
sdh: 142.25 ms
sdh: 148.50 ms
sdh: 174.00 ms
sdh: 176.00 ms
sdh: 180.00 ms
sdh: 51.00 ms
sdh: 51.17 ms
sdh: 51.25 ms
sdh: 52.00 ms
sdh: 52.33 ms
sdh: 52.75 ms
sdh: 53.00 ms
sdh: 53.50 ms
sdh: 53.67 ms
sdh: 54.00 ms
sdh: 54.75 ms
sdh: 55.00 ms
sdh: 55.60 ms
sdh: 55.67 ms
sdh: 56.33 ms
sdh: 56.38 ms
sdh: 58.00 ms
sdh: 58.50 ms
sdh: 59.25 ms
sdh: 59.67 ms
sdh: 60.67 ms
sdh: 61.00 ms
sdh: 61.33 ms
sdh: 61.40 ms
sdh: 61.50 ms
sdh: 62.40 ms
sdh: 62.50 ms
sdh: 63.00 ms
sdh: 64.75 ms
sdh: 65.60 ms
sdh: 66.00 ms
sdh: 66.33 ms
sdh: 66.86 ms
sdh: 67.00 ms
sdh: 68.00 ms
sdh: 68.33 ms
sdh: 69.50 ms
sdh: 69.80 ms
sdh: 70.00 ms
sdh: 70.14 ms
sdh: 70.17 ms
sdh: 70.25 ms
sdh: 71.60 ms
sdh: 72.25 ms
sdh: 72.83 ms
sdh: 73.50 ms
sdh: 73.80 ms
sdh: 73.83 ms
sdh: 74.67 ms
sdh: 74.80 ms
sdh: 75.00 ms
sdh: 75.50 ms
sdh: 75.80 ms
sdh: 75.83 ms
sdh: 76.33 ms
sdh: 77.00 ms
sdh: 77.60 ms
sdh: 77.83 ms
sdh: 78.33 ms
sdh: 79.17 ms
sdh: 79.60 ms
sdh: 80.67 ms
sdh: 81.33 ms
sdh: 81.67 ms
sdh: 82.00 ms
sdh: 83.00 ms
sdh: 83.75 ms
sdh: 83.83 ms
sdh: 84.50 ms
sdh: 86.83 ms
sdh: 87.17 ms
sdh: 87.75 ms
sdh: 89.75 ms
sdh: 90.00 ms
sdh: 90.25 ms
sdh: 90.75 ms
sdh: 91.00 ms
sdh: 91.80 ms
sdh: 92.50 ms
sdh: 92.75 ms
sdh: 92.83 ms
sdh: 93.25 ms
sdh: 94.50 ms
sdh: 94.75 ms
sdh: 95.00 ms
sdh: 95.50 ms
sdh: 96.75 ms
sdh: 98.00 ms
sdi: 101.00 ms
sdi: 102.00 ms
sdi: 103.00 ms
sdi: 104.25 ms
sdi: 105.00 ms
sdi: 105.50 ms
sdi: 105.80 ms
sdi: 106.71 ms
sdi: 110.71 ms
sdi: 111.75 ms
sdi: 112.00 ms
sdi: 112.50 ms
sdi: 112.60 ms
sdi: 112.67 ms
sdi: 113.50 ms
sdi: 115.50 ms
sdi: 116.33 ms
sdi: 117.33 ms
sdi: 118.00 ms
sdi: 118.33 ms
sdi: 119.67 ms
sdi: 122.00 ms
sdi: 122.33 ms
sdi: 126.33 ms
sdi: 137.25 ms
sdi: 141.75 ms
sdi: 145.00 ms
sdi: 155.00 ms
sdi: 213.00 ms
sdi: 50.33 ms
sdi: 50.50 ms
sdi: 51.00 ms
sdi: 51.40 ms
sdi: 51.50 ms
sdi: 51.75 ms
sdi: 52.00 ms
sdi: 52.17 ms
sdi: 54.00 ms
sdi: 54.25 ms
sdi: 54.33 ms
sdi: 55.33 ms
sdi: 56.00 ms
sdi: 58.00 ms
sdi: 58.50 ms
sdi: 59.17 ms
sdi: 60.50 ms
sdi: 62.50 ms
sdi: 63.67 ms
sdi: 65.00 ms
sdi: 65.75 ms
sdi: 67.00 ms
sdi: 67.11 ms
sdi: 67.20 ms
sdi: 67.50 ms
sdi: 67.67 ms
sdi: 67.86 ms
sdi: 68.00 ms
sdi: 69.57 ms
sdi: 70.50 ms
sdi: 70.83 ms
sdi: 74.20 ms
sdi: 75.00 ms
sdi: 75.25 ms
sdi: 75.67 ms
sdi: 76.60 ms
sdi: 78.00 ms
sdi: 79.40 ms
sdi: 80.00 ms
sdi: 80.50 ms
sdi: 80.80 ms
sdi: 81.00 ms
sdi: 81.50 ms
sdi: 82.60 ms
sdi: 82.67 ms
sdi: 82.80 ms
sdi: 83.00 ms
sdi: 83.33 ms
sdi: 84.40 ms
sdi: 84.83 ms
sdi: 85.00 ms
sdi: 85.50 ms
sdi: 86.00 ms
sdi: 86.50 ms
sdi: 87.00 ms
sdi: 88.17 ms
sdi: 89.00 ms
sdi: 90.00 ms
sdi: 90.25 ms
sdi: 90.80 ms
sdi: 91.33 ms
sdi: 91.50 ms
sdi: 91.75 ms
sdi: 92.00 ms
sdi: 92.80 ms
sdi: 93.00 ms
sdi: 93.33 ms
sdi: 93.83 ms
sdi: 94.17 ms
sdi: 94.25 ms
sdi: 94.50 ms
sdi: 94.75 ms
sdi: 95.00 ms
sdi: 95.80 ms
sdi: 96.00 ms
sdi: 96.25 ms
sdi: 96.83 ms
sdi: 97.25 ms
sdi: 97.50 ms
sdi: 98.00 ms
sdi: 98.25 ms
sdi: 98.50 ms
sdi: 99.75 ms
sdj: 100.50 ms
sdj: 100.75 ms
sdj: 101.14 ms
sdj: 101.50 ms
sdj: 102.00 ms
sdj: 103.25 ms
sdj: 104.00 ms
sdj: 105.00 ms
sdj: 105.50 ms
sdj: 105.75 ms
sdj: 106.57 ms
sdj: 107.25 ms
sdj: 108.50 ms
sdj: 109.00 ms
sdj: 111.50 ms
sdj: 112.00 ms
sdj: 115.33 ms
sdj: 116.33 ms
sdj: 116.67 ms
sdj: 117.00 ms
sdj: 118.67 ms
sdj: 119.00 ms
sdj: 119.33 ms
sdj: 119.50 ms
sdj: 120.00 ms
sdj: 122.67 ms
sdj: 123.33 ms
sdj: 126.50 ms
sdj: 128.00 ms
sdj: 130.00 ms
sdj: 133.00 ms
sdj: 145.00 ms
sdj: 166.00 ms
sdj: 181.00 ms
sdj: 50.57 ms
sdj: 51.25 ms
sdj: 51.50 ms
sdj: 51.75 ms
sdj: 52.17 ms
sdj: 52.83 ms
sdj: 53.75 ms
sdj: 54.00 ms
sdj: 54.33 ms
sdj: 55.00 ms
sdj: 55.33 ms
sdj: 55.40 ms
sdj: 55.43 ms
sdj: 55.50 ms
sdj: 56.50 ms
sdj: 56.80 ms
sdj: 57.75 ms
sdj: 58.17 ms
sdj: 59.00 ms
sdj: 60.00 ms
sdj: 61.38 ms
sdj: 62.50 ms
sdj: 63.14 ms
sdj: 64.75 ms
sdj: 65.00 ms
sdj: 65.25 ms
sdj: 65.40 ms
sdj: 66.67 ms
sdj: 67.00 ms
sdj: 67.67 ms
sdj: 67.83 ms
sdj: 69.78 ms
sdj: 70.20 ms
sdj: 70.50 ms
sdj: 71.17 ms
sdj: 72.00 ms
sdj: 72.14 ms
sdj: 72.20 ms
sdj: 73.00 ms
sdj: 73.50 ms
sdj: 73.75 ms
sdj: 74.00 ms
sdj: 75.33 ms
sdj: 75.67 ms
sdj: 76.00 ms
sdj: 77.22 ms
sdj: 78.00 ms
sdj: 78.83 ms
sdj: 79.20 ms
sdj: 79.40 ms
sdj: 79.67 ms
sdj: 79.86 ms
sdj: 80.00 ms
sdj: 80.71 ms
sdj: 81.14 ms
sdj: 81.40 ms
sdj: 82.00 ms
sdj: 83.25 ms
sdj: 83.40 ms
sdj: 83.83 ms
sdj: 84.17 ms
sdj: 84.67 ms
sdj: 85.50 ms
sdj: 86.17 ms
sdj: 86.29 ms
sdj: 86.50 ms
sdj: 87.25 ms
sdj: 87.50 ms
sdj: 88.25 ms
sdj: 88.33 ms
sdj: 88.40 ms
sdj: 89.17 ms
sdj: 89.50 ms
sdj: 90.00 ms
sdj: 90.50 ms
sdj: 91.00 ms
sdj: 91.33 ms
sdj: 92.00 ms
sdj: 92.25 ms
sdj: 92.50 ms
sdj: 94.00 ms
sdj: 94.33 ms
sdj: 94.50 ms
sdj: 94.75 ms
sdj: 95.83 ms
sdj: 96.00 ms
sdj: 96.25 ms
sdj: 97.50 ms
sdj: 97.83 ms
sdj: 99.00 ms
sdj: 99.25 ms
sdk: 100.00 ms
sdk: 100.50 ms
sdk: 101.00 ms
sdk: 101.25 ms
sdk: 103.50 ms
sdk: 103.75 ms
sdk: 103.86 ms
sdk: 104.00 ms
sdk: 105.00 ms
sdk: 106.43 ms
sdk: 106.50 ms
sdk: 107.43 ms
sdk: 108.50 ms
sdk: 108.67 ms
sdk: 111.14 ms
sdk: 118.00 ms
sdk: 120.33 ms
sdk: 125.00 ms
sdk: 127.00 ms
sdk: 128.25 ms
sdk: 136.00 ms
sdk: 137.25 ms
sdk: 137.75 ms
sdk: 138.50 ms
sdk: 148.00 ms
sdk: 175.50 ms
sdk: 180.00 ms
sdk: 50.75 ms
sdk: 50.80 ms
sdk: 51.00 ms
sdk: 51.29 ms
sdk: 52.00 ms
sdk: 52.17 ms
sdk: 53.00 ms
sdk: 53.17 ms
sdk: 53.33 ms
sdk: 53.40 ms
sdk: 53.67 ms
sdk: 55.00 ms
sdk: 56.00 ms
sdk: 56.20 ms
sdk: 56.33 ms
sdk: 57.60 ms
sdk: 57.83 ms
sdk: 57.86 ms
sdk: 58.38 ms
sdk: 59.25 ms
sdk: 60.00 ms
sdk: 60.22 ms
sdk: 61.17 ms
sdk: 66.00 ms
sdk: 66.43 ms
sdk: 67.00 ms
sdk: 67.25 ms
sdk: 69.00 ms
sdk: 69.17 ms
sdk: 69.22 ms
sdk: 70.33 ms
sdk: 70.67 ms
sdk: 70.80 ms
sdk: 70.88 ms
sdk: 71.71 ms
sdk: 71.83 ms
sdk: 72.67 ms
sdk: 73.00 ms
sdk: 73.50 ms
sdk: 73.86 ms
sdk: 74.50 ms
sdk: 74.83 ms
sdk: 75.33 ms
sdk: 75.50 ms
sdk: 75.67 ms
sdk: 76.00 ms
sdk: 76.33 ms
sdk: 76.50 ms
sdk: 77.33 ms
sdk: 78.20 ms
sdk: 78.50 ms
sdk: 79.20 ms
sdk: 79.40 ms
sdk: 79.50 ms
sdk: 80.00 ms
sdk: 80.38 ms
sdk: 80.80 ms
sdk: 81.83 ms
sdk: 82.00 ms
sdk: 82.17 ms
sdk: 82.80 ms
sdk: 83.50 ms
sdk: 83.80 ms
sdk: 84.83 ms
sdk: 85.00 ms
sdk: 86.00 ms
sdk: 88.17 ms
sdk: 88.25 ms
sdk: 88.50 ms
sdk: 89.20 ms
sdk: 89.25 ms
sdk: 89.40 ms
sdk: 89.50 ms
sdk: 90.00 ms
sdk: 90.60 ms
sdk: 90.75 ms
sdk: 91.75 ms
sdk: 92.00 ms
sdk: 92.20 ms
sdk: 92.25 ms
sdk: 92.50 ms
sdk: 93.00 ms
sdk: 93.25 ms
sdk: 93.50 ms
sdk: 93.67 ms
sdk: 94.00 ms
sdk: 94.50 ms
sdk: 94.75 ms
sdk: 95.00 ms
sdk: 95.25 ms
sdk: 95.50 ms
sdk: 96.00 ms
sdk: 96.17 ms
sdk: 96.25 ms
sdk: 96.75 ms
sdk: 97.00 ms
sdk: 97.50 ms
sdk: 97.75 ms
sdk: 98.50 ms
sdk: 99.00 ms
sdk: 99.25 ms
sdk: 99.40 ms
sdl: 100.00 ms
sdl: 101.50 ms
sdl: 103.75 ms
sdl: 104.29 ms
sdl: 106.00 ms
sdl: 109.00 ms
sdl: 110.67 ms
sdl: 112.67 ms
sdl: 113.33 ms
sdl: 116.33 ms
sdl: 117.33 ms
sdl: 121.67 ms
sdl: 122.00 ms
sdl: 122.33 ms
sdl: 124.00 ms
sdl: 125.00 ms
sdl: 127.83 ms
sdl: 129.33 ms
sdl: 132.67 ms
sdl: 136.25 ms
sdl: 147.00 ms
sdl: 153.00 ms
sdl: 234.00 ms
sdl: 50.25 ms
sdl: 50.33 ms
sdl: 50.60 ms
sdl: 50.83 ms
sdl: 51.33 ms
sdl: 51.75 ms
sdl: 51.80 ms
sdl: 52.00 ms
sdl: 52.33 ms
sdl: 53.00 ms
sdl: 53.17 ms
sdl: 53.50 ms
sdl: 53.83 ms
sdl: 54.00 ms
sdl: 55.75 ms
sdl: 56.00 ms
sdl: 56.67 ms
sdl: 57.00 ms
sdl: 57.29 ms
sdl: 57.33 ms
sdl: 57.67 ms
sdl: 58.67 ms
sdl: 63.00 ms
sdl: 65.17 ms
sdl: 65.33 ms
sdl: 65.43 ms
sdl: 66.20 ms
sdl: 66.33 ms
sdl: 66.62 ms
sdl: 66.75 ms
sdl: 68.57 ms
sdl: 69.50 ms
sdl: 70.43 ms
sdl: 71.00 ms
sdl: 71.17 ms
sdl: 71.20 ms
sdl: 72.00 ms
sdl: 73.80 ms
sdl: 74.25 ms
sdl: 75.50 ms
sdl: 75.83 ms
sdl: 76.00 ms
sdl: 76.29 ms
sdl: 76.33 ms
sdl: 76.40 ms
sdl: 76.67 ms
sdl: 76.80 ms
sdl: 77.00 ms
sdl: 77.33 ms
sdl: 77.40 ms
sdl: 77.50 ms
sdl: 79.33 ms
sdl: 80.00 ms
sdl: 80.17 ms
sdl: 80.67 ms
sdl: 81.67 ms
sdl: 82.00 ms
sdl: 82.80 ms
sdl: 83.00 ms
sdl: 84.25 ms
sdl: 85.00 ms
sdl: 85.75 ms
sdl: 85.83 ms
sdl: 86.20 ms
sdl: 87.50 ms
sdl: 87.75 ms
sdl: 88.33 ms
sdl: 89.00 ms
sdl: 89.17 ms
sdl: 90.00 ms
sdl: 91.00 ms
sdl: 91.40 ms
sdl: 91.75 ms
sdl: 93.25 ms
sdl: 93.50 ms
sdl: 93.75 ms
sdl: 94.50 ms
sdl: 94.75 ms
sdl: 95.25 ms
sdl: 95.50 ms
sdl: 95.75 ms
sdl: 96.25 ms
sdl: 97.00 ms
sdl: 97.50 ms
sdl: 97.75 ms
sdl: 98.25 ms
```

---

### 网络问题分析

⚠ **检测到网络问题**

**重传统计：**
    3597 segments retransmitted
    98 fast retransmits
    12 retransmits in slow start

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

