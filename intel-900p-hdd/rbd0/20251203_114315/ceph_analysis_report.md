# Ceph 性能瓶颈分析报告

**分析时间**: 2025-12-03 11:50:50
**监控数据目录**: /home/ubuntu/intel-900p-hdd/rbd0/20251203_114315/ceph-monitoring

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
dm-17: 90.20%
dm-17: 98.00%
dm-21: 93.40%
dm-25: 90.50%
dm-25: 94.20%
dm-7: 90.80%
rbd0: 100.00%
rbd0: 100.10%
rbd0: 100.20%
rbd0: 90.30%
rbd0: 90.40%
rbd0: 91.70%
rbd0: 91.80%
rbd0: 92.30%
rbd0: 92.80%
rbd0: 92.90%
rbd0: 93.50%
rbd0: 93.70%
rbd0: 94.00%
rbd0: 94.20%
rbd0: 94.30%
rbd0: 94.40%
rbd0: 94.60%
rbd0: 94.90%
rbd0: 95.00%
rbd0: 95.20%
rbd0: 95.80%
rbd0: 96.00%
rbd0: 96.30%
rbd0: 96.50%
rbd0: 96.60%
rbd0: 96.70%
rbd0: 96.90%
rbd0: 97.00%
rbd0: 97.10%
rbd0: 97.20%
rbd0: 97.30%
rbd0: 97.40%
rbd0: 97.60%
rbd0: 97.70%
rbd0: 97.80%
rbd0: 97.90%
rbd0: 98.00%
rbd0: 98.10%
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
rbd0: 99.80%
rbd0: 99.90%
sda: 90.50%
sda: 94.30%
sdd: 26326.40%
sdd: 90.20%
sdd: 97.90%
sdg: 90.90%
sdj: 93.40%
```

**建议**: 高利用率磁盘可能成为瓶颈，检查是否为慢盘或负载不均。

**⚠ 检测到高延迟磁盘（await > 50ms）：**
```
sda: 100.50 ms
sda: 101.25 ms
sda: 102.50 ms
sda: 103.29 ms
sda: 104.00 ms
sda: 105.00 ms
sda: 105.25 ms
sda: 110.50 ms
sda: 115.33 ms
sda: 119.00 ms
sda: 122.00 ms
sda: 122.67 ms
sda: 125.67 ms
sda: 128.00 ms
sda: 128.67 ms
sda: 130.00 ms
sda: 132.33 ms
sda: 137.67 ms
sda: 140.75 ms
sda: 170.00 ms
sda: 183.00 ms
sda: 192.00 ms
sda: 50.75 ms
sda: 50.83 ms
sda: 51.25 ms
sda: 52.00 ms
sda: 52.25 ms
sda: 52.33 ms
sda: 52.67 ms
sda: 53.17 ms
sda: 53.25 ms
sda: 53.67 ms
sda: 53.75 ms
sda: 54.00 ms
sda: 54.25 ms
sda: 54.67 ms
sda: 54.75 ms
sda: 55.40 ms
sda: 55.50 ms
sda: 55.67 ms
sda: 57.00 ms
sda: 58.67 ms
sda: 59.33 ms
sda: 59.67 ms
sda: 60.00 ms
sda: 60.40 ms
sda: 60.67 ms
sda: 62.00 ms
sda: 64.00 ms
sda: 64.20 ms
sda: 64.33 ms
sda: 65.00 ms
sda: 65.67 ms
sda: 67.33 ms
sda: 68.00 ms
sda: 68.25 ms
sda: 68.50 ms
sda: 70.40 ms
sda: 72.50 ms
sda: 75.00 ms
sda: 75.86 ms
sda: 76.50 ms
sda: 77.00 ms
sda: 77.40 ms
sda: 78.80 ms
sda: 80.40 ms
sda: 81.17 ms
sda: 81.83 ms
sda: 83.20 ms
sda: 83.83 ms
sda: 87.00 ms
sda: 87.20 ms
sda: 87.40 ms
sda: 87.83 ms
sda: 88.00 ms
sda: 89.00 ms
sda: 90.75 ms
sda: 91.00 ms
sda: 91.40 ms
sda: 92.25 ms
sda: 93.50 ms
sda: 95.17 ms
sda: 95.25 ms
sda: 95.50 ms
sda: 96.25 ms
sda: 96.67 ms
sda: 96.83 ms
sda: 97.00 ms
sda: 97.25 ms
sda: 97.75 ms
sda: 98.00 ms
sda: 98.25 ms
sda: 98.50 ms
sda: 99.00 ms
sda: 99.75 ms
sdb: 100.25 ms
sdb: 102.25 ms
sdb: 104.00 ms
sdb: 106.00 ms
sdb: 107.00 ms
sdb: 107.50 ms
sdb: 107.80 ms
sdb: 111.40 ms
sdb: 114.40 ms
sdb: 116.00 ms
sdb: 116.33 ms
sdb: 117.67 ms
sdb: 118.00 ms
sdb: 119.33 ms
sdb: 121.33 ms
sdb: 121.67 ms
sdb: 122.67 ms
sdb: 123.33 ms
sdb: 125.67 ms
sdb: 126.00 ms
sdb: 128.00 ms
sdb: 131.00 ms
sdb: 134.00 ms
sdb: 134.33 ms
sdb: 136.00 ms
sdb: 136.33 ms
sdb: 141.33 ms
sdb: 156.00 ms
sdb: 170.00 ms
sdb: 186.00 ms
sdb: 209.00 ms
sdb: 50.67 ms
sdb: 51.00 ms
sdb: 51.33 ms
sdb: 51.50 ms
sdb: 51.67 ms
sdb: 52.25 ms
sdb: 52.67 ms
sdb: 53.00 ms
sdb: 53.50 ms
sdb: 54.33 ms
sdb: 54.83 ms
sdb: 55.33 ms
sdb: 56.00 ms
sdb: 57.00 ms
sdb: 57.67 ms
sdb: 58.67 ms
sdb: 59.00 ms
sdb: 60.00 ms
sdb: 61.00 ms
sdb: 61.25 ms
sdb: 61.67 ms
sdb: 62.00 ms
sdb: 62.67 ms
sdb: 63.40 ms
sdb: 63.67 ms
sdb: 63.80 ms
sdb: 64.67 ms
sdb: 65.00 ms
sdb: 66.33 ms
sdb: 66.67 ms
sdb: 68.00 ms
sdb: 69.67 ms
sdb: 70.50 ms
sdb: 70.83 ms
sdb: 72.00 ms
sdb: 74.25 ms
sdb: 77.00 ms
sdb: 77.33 ms
sdb: 81.00 ms
sdb: 81.83 ms
sdb: 84.00 ms
sdb: 84.60 ms
sdb: 86.20 ms
sdb: 87.33 ms
sdb: 87.60 ms
sdb: 88.00 ms
sdb: 91.75 ms
sdb: 91.80 ms
sdb: 94.75 ms
sdb: 96.00 ms
sdb: 96.25 ms
sdb: 96.50 ms
sdb: 97.50 ms
sdc: 100.75 ms
sdc: 101.50 ms
sdc: 106.50 ms
sdc: 109.50 ms
sdc: 112.00 ms
sdc: 113.00 ms
sdc: 115.00 ms
sdc: 115.67 ms
sdc: 116.00 ms
sdc: 116.67 ms
sdc: 119.33 ms
sdc: 121.33 ms
sdc: 123.00 ms
sdc: 125.50 ms
sdc: 126.00 ms
sdc: 128.33 ms
sdc: 130.67 ms
sdc: 131.00 ms
sdc: 131.33 ms
sdc: 134.33 ms
sdc: 136.67 ms
sdc: 137.33 ms
sdc: 141.67 ms
sdc: 142.33 ms
sdc: 143.00 ms
sdc: 184.00 ms
sdc: 189.00 ms
sdc: 197.00 ms
sdc: 50.33 ms
sdc: 51.33 ms
sdc: 51.40 ms
sdc: 51.50 ms
sdc: 51.67 ms
sdc: 52.00 ms
sdc: 52.33 ms
sdc: 53.00 ms
sdc: 53.83 ms
sdc: 54.00 ms
sdc: 54.33 ms
sdc: 55.33 ms
sdc: 55.67 ms
sdc: 55.83 ms
sdc: 57.00 ms
sdc: 57.33 ms
sdc: 57.75 ms
sdc: 58.83 ms
sdc: 59.00 ms
sdc: 59.33 ms
sdc: 59.75 ms
sdc: 60.33 ms
sdc: 60.67 ms
sdc: 62.50 ms
sdc: 62.67 ms
sdc: 63.20 ms
sdc: 64.00 ms
sdc: 66.00 ms
sdc: 66.67 ms
sdc: 67.67 ms
sdc: 68.00 ms
sdc: 69.00 ms
sdc: 72.00 ms
sdc: 72.83 ms
sdc: 73.00 ms
sdc: 74.00 ms
sdc: 74.67 ms
sdc: 75.00 ms
sdc: 76.60 ms
sdc: 78.00 ms
sdc: 78.20 ms
sdc: 79.00 ms
sdc: 79.20 ms
sdc: 84.17 ms
sdc: 87.33 ms
sdc: 91.00 ms
sdc: 94.00 ms
sdc: 94.50 ms
sdc: 96.50 ms
sdc: 96.75 ms
sdc: 98.50 ms
sdc: 98.75 ms
sdd: 100.00 ms
sdd: 102.00 ms
sdd: 102.40 ms
sdd: 103.25 ms
sdd: 103.50 ms
sdd: 104.40 ms
sdd: 106.50 ms
sdd: 107.00 ms
sdd: 108.50 ms
sdd: 109.00 ms
sdd: 109.40 ms
sdd: 111.00 ms
sdd: 112.86 ms
sdd: 113.20 ms
sdd: 114.33 ms
sdd: 115.00 ms
sdd: 117.00 ms
sdd: 118.00 ms
sdd: 120.00 ms
sdd: 121.00 ms
sdd: 122.00 ms
sdd: 122.33 ms
sdd: 123.67 ms
sdd: 124.33 ms
sdd: 124.67 ms
sdd: 126.00 ms
sdd: 127.00 ms
sdd: 127.67 ms
sdd: 128.00 ms
sdd: 130.00 ms
sdd: 130.33 ms
sdd: 131.00 ms
sdd: 134.00 ms
sdd: 140.00 ms
sdd: 140.25 ms
sdd: 50.20 ms
sdd: 50.67 ms
sdd: 50.75 ms
sdd: 51.00 ms
sdd: 51.40 ms
sdd: 51.50 ms
sdd: 52.00 ms
sdd: 52.33 ms
sdd: 52.67 ms
sdd: 53.33 ms
sdd: 53.75 ms
sdd: 53.83 ms
sdd: 54.00 ms
sdd: 54.33 ms
sdd: 54.60 ms
sdd: 54.75 ms
sdd: 55.00 ms
sdd: 55.17 ms
sdd: 55.50 ms
sdd: 55.67 ms
sdd: 56.33 ms
sdd: 57.00 ms
sdd: 57.60 ms
sdd: 58.00 ms
sdd: 59.25 ms
sdd: 59.67 ms
sdd: 60.00 ms
sdd: 60.40 ms
sdd: 60.67 ms
sdd: 60.80 ms
sdd: 62.33 ms
sdd: 63.50 ms
sdd: 64.00 ms
sdd: 65.33 ms
sdd: 66.17 ms
sdd: 67.00 ms
sdd: 68.00 ms
sdd: 68.33 ms
sdd: 70.67 ms
sdd: 71.12 ms
sdd: 72.25 ms
sdd: 72.33 ms
sdd: 73.17 ms
sdd: 74.29 ms
sdd: 75.60 ms
sdd: 76.43 ms
sdd: 77.33 ms
sdd: 77.67 ms
sdd: 78.20 ms
sdd: 79.83 ms
sdd: 80.60 ms
sdd: 81.00 ms
sdd: 81.20 ms
sdd: 81.60 ms
sdd: 81.67 ms
sdd: 81.80 ms
sdd: 83.00 ms
sdd: 83.20 ms
sdd: 85.75 ms
sdd: 89.40 ms
sdd: 90.20 ms
sdd: 90.50 ms
sdd: 91.67 ms
sdd: 93.83 ms
sdd: 94.25 ms
sdd: 94.75 ms
sdd: 95.33 ms
sdd: 96.25 ms
sdd: 96.75 ms
sdd: 97.75 ms
sdd: 98.50 ms
sdd: 98.75 ms
sdd: 99.00 ms
sdd: 99.50 ms
sde: 101.50 ms
sde: 102.00 ms
sde: 102.25 ms
sde: 103.20 ms
sde: 104.50 ms
sde: 107.50 ms
sde: 108.50 ms
sde: 109.50 ms
sde: 113.50 ms
sde: 113.67 ms
sde: 116.67 ms
sde: 121.00 ms
sde: 121.67 ms
sde: 124.00 ms
sde: 125.33 ms
sde: 126.67 ms
sde: 130.75 ms
sde: 132.00 ms
sde: 133.33 ms
sde: 144.50 ms
sde: 151.00 ms
sde: 152.00 ms
sde: 158.00 ms
sde: 161.00 ms
sde: 166.00 ms
sde: 167.00 ms
sde: 170.00 ms
sde: 176.50 ms
sde: 177.00 ms
sde: 184.00 ms
sde: 50.50 ms
sde: 51.50 ms
sde: 52.25 ms
sde: 52.33 ms
sde: 53.00 ms
sde: 53.25 ms
sde: 54.00 ms
sde: 54.20 ms
sde: 54.75 ms
sde: 56.00 ms
sde: 56.33 ms
sde: 56.50 ms
sde: 56.67 ms
sde: 56.75 ms
sde: 57.00 ms
sde: 57.33 ms
sde: 57.40 ms
sde: 58.00 ms
sde: 58.33 ms
sde: 58.50 ms
sde: 59.25 ms
sde: 59.67 ms
sde: 59.75 ms
sde: 60.00 ms
sde: 60.17 ms
sde: 61.00 ms
sde: 61.33 ms
sde: 61.67 ms
sde: 65.00 ms
sde: 65.67 ms
sde: 66.33 ms
sde: 67.50 ms
sde: 67.67 ms
sde: 68.50 ms
sde: 68.67 ms
sde: 69.33 ms
sde: 70.67 ms
sde: 71.33 ms
sde: 73.00 ms
sde: 73.67 ms
sde: 76.40 ms
sde: 77.67 ms
sde: 80.00 ms
sde: 80.75 ms
sde: 81.00 ms
sde: 81.75 ms
sde: 82.25 ms
sde: 84.67 ms
sde: 85.00 ms
sde: 85.40 ms
sde: 86.33 ms
sde: 88.17 ms
sde: 88.60 ms
sde: 89.60 ms
sde: 91.33 ms
sde: 92.00 ms
sde: 93.40 ms
sde: 93.50 ms
sde: 94.75 ms
sde: 96.00 ms
sde: 99.50 ms
sde: 99.75 ms
sdf: 100.40 ms
sdf: 101.00 ms
sdf: 101.75 ms
sdf: 103.50 ms
sdf: 103.75 ms
sdf: 104.75 ms
sdf: 105.75 ms
sdf: 107.00 ms
sdf: 108.00 ms
sdf: 111.00 ms
sdf: 112.33 ms
sdf: 113.33 ms
sdf: 117.00 ms
sdf: 117.33 ms
sdf: 119.00 ms
sdf: 119.67 ms
sdf: 121.33 ms
sdf: 122.00 ms
sdf: 123.67 ms
sdf: 124.00 ms
sdf: 124.33 ms
sdf: 129.00 ms
sdf: 131.33 ms
sdf: 132.67 ms
sdf: 133.67 ms
sdf: 134.00 ms
sdf: 136.00 ms
sdf: 166.00 ms
sdf: 182.00 ms
sdf: 187.00 ms
sdf: 50.25 ms
sdf: 50.75 ms
sdf: 51.00 ms
sdf: 51.25 ms
sdf: 51.50 ms
sdf: 51.67 ms
sdf: 51.75 ms
sdf: 52.00 ms
sdf: 52.33 ms
sdf: 53.00 ms
sdf: 53.33 ms
sdf: 53.67 ms
sdf: 54.33 ms
sdf: 54.67 ms
sdf: 54.75 ms
sdf: 55.00 ms
sdf: 56.00 ms
sdf: 56.33 ms
sdf: 57.00 ms
sdf: 58.00 ms
sdf: 58.33 ms
sdf: 59.33 ms
sdf: 59.50 ms
sdf: 60.00 ms
sdf: 62.00 ms
sdf: 62.33 ms
sdf: 64.67 ms
sdf: 65.00 ms
sdf: 67.67 ms
sdf: 68.67 ms
sdf: 69.00 ms
sdf: 71.00 ms
sdf: 71.67 ms
sdf: 72.33 ms
sdf: 72.67 ms
sdf: 73.00 ms
sdf: 73.33 ms
sdf: 73.67 ms
sdf: 74.33 ms
sdf: 78.00 ms
sdf: 81.00 ms
sdf: 81.50 ms
sdf: 81.60 ms
sdf: 82.40 ms
sdf: 82.50 ms
sdf: 84.60 ms
sdf: 84.75 ms
sdf: 86.00 ms
sdf: 87.67 ms
sdf: 88.40 ms
sdf: 88.83 ms
sdf: 90.00 ms
sdf: 93.75 ms
sdf: 95.00 ms
sdf: 95.25 ms
sdf: 96.25 ms
sdf: 98.50 ms
sdf: 98.75 ms
sdf: 99.50 ms
sdg: 100.00 ms
sdg: 100.50 ms
sdg: 101.50 ms
sdg: 101.75 ms
sdg: 102.50 ms
sdg: 104.00 ms
sdg: 104.75 ms
sdg: 105.00 ms
sdg: 107.75 ms
sdg: 108.20 ms
sdg: 108.29 ms
sdg: 109.50 ms
sdg: 111.50 ms
sdg: 112.33 ms
sdg: 115.33 ms
sdg: 115.67 ms
sdg: 116.83 ms
sdg: 118.00 ms
sdg: 121.00 ms
sdg: 124.33 ms
sdg: 124.67 ms
sdg: 125.33 ms
sdg: 128.00 ms
sdg: 131.33 ms
sdg: 132.67 ms
sdg: 134.00 ms
sdg: 143.75 ms
sdg: 153.00 ms
sdg: 164.00 ms
sdg: 170.00 ms
sdg: 175.00 ms
sdg: 201.00 ms
sdg: 205.00 ms
sdg: 50.33 ms
sdg: 50.50 ms
sdg: 51.33 ms
sdg: 51.67 ms
sdg: 51.86 ms
sdg: 52.00 ms
sdg: 52.25 ms
sdg: 52.50 ms
sdg: 52.67 ms
sdg: 52.75 ms
sdg: 53.33 ms
sdg: 53.67 ms
sdg: 53.75 ms
sdg: 54.00 ms
sdg: 54.67 ms
sdg: 55.00 ms
sdg: 55.33 ms
sdg: 56.00 ms
sdg: 56.25 ms
sdg: 56.40 ms
sdg: 56.50 ms
sdg: 57.00 ms
sdg: 57.20 ms
sdg: 58.00 ms
sdg: 58.50 ms
sdg: 59.33 ms
sdg: 60.00 ms
sdg: 60.33 ms
sdg: 62.33 ms
sdg: 62.67 ms
sdg: 63.60 ms
sdg: 63.67 ms
sdg: 65.00 ms
sdg: 65.33 ms
sdg: 68.00 ms
sdg: 68.20 ms
sdg: 68.33 ms
sdg: 68.40 ms
sdg: 69.00 ms
sdg: 69.40 ms
sdg: 69.67 ms
sdg: 71.00 ms
sdg: 71.33 ms
sdg: 72.00 ms
sdg: 72.33 ms
sdg: 73.33 ms
sdg: 75.67 ms
sdg: 76.25 ms
sdg: 77.00 ms
sdg: 78.67 ms
sdg: 80.00 ms
sdg: 81.00 ms
sdg: 82.00 ms
sdg: 83.20 ms
sdg: 84.00 ms
sdg: 84.40 ms
sdg: 85.00 ms
sdg: 86.20 ms
sdg: 86.80 ms
sdg: 87.17 ms
sdg: 91.00 ms
sdg: 91.50 ms
sdg: 92.00 ms
sdg: 93.00 ms
sdg: 93.25 ms
sdg: 93.33 ms
sdg: 94.00 ms
sdg: 94.60 ms
sdg: 96.00 ms
sdg: 98.00 ms
sdg: 98.25 ms
sdg: 98.75 ms
sdg: 99.25 ms
sdh: 101.00 ms
sdh: 101.25 ms
sdh: 101.50 ms
sdh: 101.75 ms
sdh: 102.25 ms
sdh: 102.50 ms
sdh: 103.25 ms
sdh: 105.75 ms
sdh: 106.00 ms
sdh: 109.00 ms
sdh: 111.00 ms
sdh: 114.00 ms
sdh: 114.25 ms
sdh: 114.33 ms
sdh: 116.00 ms
sdh: 117.67 ms
sdh: 119.00 ms
sdh: 120.67 ms
sdh: 122.00 ms
sdh: 122.67 ms
sdh: 123.50 ms
sdh: 126.33 ms
sdh: 129.67 ms
sdh: 130.00 ms
sdh: 132.33 ms
sdh: 133.00 ms
sdh: 133.33 ms
sdh: 134.67 ms
sdh: 143.00 ms
sdh: 146.00 ms
sdh: 176.00 ms
sdh: 189.00 ms
sdh: 202.00 ms
sdh: 50.25 ms
sdh: 50.50 ms
sdh: 50.67 ms
sdh: 50.75 ms
sdh: 51.25 ms
sdh: 51.50 ms
sdh: 52.33 ms
sdh: 52.50 ms
sdh: 53.40 ms
sdh: 54.00 ms
sdh: 54.50 ms
sdh: 54.67 ms
sdh: 55.80 ms
sdh: 56.00 ms
sdh: 56.33 ms
sdh: 57.00 ms
sdh: 57.50 ms
sdh: 57.67 ms
sdh: 58.67 ms
sdh: 59.00 ms
sdh: 59.25 ms
sdh: 59.67 ms
sdh: 59.86 ms
sdh: 61.67 ms
sdh: 62.67 ms
sdh: 63.00 ms
sdh: 63.50 ms
sdh: 63.67 ms
sdh: 64.00 ms
sdh: 64.17 ms
sdh: 64.67 ms
sdh: 65.29 ms
sdh: 65.86 ms
sdh: 66.40 ms
sdh: 67.29 ms
sdh: 68.00 ms
sdh: 71.83 ms
sdh: 73.00 ms
sdh: 75.00 ms
sdh: 75.50 ms
sdh: 76.00 ms
sdh: 77.00 ms
sdh: 78.33 ms
sdh: 78.67 ms
sdh: 80.00 ms
sdh: 80.67 ms
sdh: 81.43 ms
sdh: 82.33 ms
sdh: 83.50 ms
sdh: 85.00 ms
sdh: 85.20 ms
sdh: 86.40 ms
sdh: 87.20 ms
sdh: 87.60 ms
sdh: 87.67 ms
sdh: 88.00 ms
sdh: 88.50 ms
sdh: 88.60 ms
sdh: 90.80 ms
sdh: 91.50 ms
sdh: 91.57 ms
sdh: 93.25 ms
sdh: 93.50 ms
sdh: 95.00 ms
sdh: 95.33 ms
sdh: 96.50 ms
sdh: 97.50 ms
sdh: 98.00 ms
sdh: 99.40 ms
sdi: 101.50 ms
sdi: 103.75 ms
sdi: 112.67 ms
sdi: 114.50 ms
sdi: 114.67 ms
sdi: 118.33 ms
sdi: 119.00 ms
sdi: 119.33 ms
sdi: 124.33 ms
sdi: 125.67 ms
sdi: 126.00 ms
sdi: 126.33 ms
sdi: 126.67 ms
sdi: 128.33 ms
sdi: 129.67 ms
sdi: 131.33 ms
sdi: 133.00 ms
sdi: 151.00 ms
sdi: 155.00 ms
sdi: 161.00 ms
sdi: 164.00 ms
sdi: 168.50 ms
sdi: 170.00 ms
sdi: 186.00 ms
sdi: 187.00 ms
sdi: 50.25 ms
sdi: 51.17 ms
sdi: 51.67 ms
sdi: 52.33 ms
sdi: 52.50 ms
sdi: 52.83 ms
sdi: 53.00 ms
sdi: 53.25 ms
sdi: 53.50 ms
sdi: 54.20 ms
sdi: 55.00 ms
sdi: 55.40 ms
sdi: 55.67 ms
sdi: 56.33 ms
sdi: 56.75 ms
sdi: 57.00 ms
sdi: 57.33 ms
sdi: 57.50 ms
sdi: 58.00 ms
sdi: 59.67 ms
sdi: 61.25 ms
sdi: 61.67 ms
sdi: 62.67 ms
sdi: 64.20 ms
sdi: 64.33 ms
sdi: 64.60 ms
sdi: 66.71 ms
sdi: 67.00 ms
sdi: 67.83 ms
sdi: 68.33 ms
sdi: 69.17 ms
sdi: 75.33 ms
sdi: 79.20 ms
sdi: 80.57 ms
sdi: 81.00 ms
sdi: 82.00 ms
sdi: 83.00 ms
sdi: 84.00 ms
sdi: 89.00 ms
sdi: 92.50 ms
sdi: 93.75 ms
sdi: 94.00 ms
sdi: 94.50 ms
sdi: 95.50 ms
sdi: 96.25 ms
sdi: 97.00 ms
sdi: 98.50 ms
sdi: 99.40 ms
sdj: 101.00 ms
sdj: 101.25 ms
sdj: 101.50 ms
sdj: 102.00 ms
sdj: 102.75 ms
sdj: 103.00 ms
sdj: 104.75 ms
sdj: 106.50 ms
sdj: 107.75 ms
sdj: 108.50 ms
sdj: 112.00 ms
sdj: 112.67 ms
sdj: 115.67 ms
sdj: 116.00 ms
sdj: 117.67 ms
sdj: 118.33 ms
sdj: 118.67 ms
sdj: 119.00 ms
sdj: 120.50 ms
sdj: 121.00 ms
sdj: 121.67 ms
sdj: 122.33 ms
sdj: 122.67 ms
sdj: 123.33 ms
sdj: 125.00 ms
sdj: 125.33 ms
sdj: 125.67 ms
sdj: 126.17 ms
sdj: 126.33 ms
sdj: 127.33 ms
sdj: 129.00 ms
sdj: 146.20 ms
sdj: 166.00 ms
sdj: 174.50 ms
sdj: 187.00 ms
sdj: 50.33 ms
sdj: 51.00 ms
sdj: 51.17 ms
sdj: 52.00 ms
sdj: 52.20 ms
sdj: 52.33 ms
sdj: 53.00 ms
sdj: 53.75 ms
sdj: 54.67 ms
sdj: 55.00 ms
sdj: 55.50 ms
sdj: 57.00 ms
sdj: 57.17 ms
sdj: 57.67 ms
sdj: 60.00 ms
sdj: 60.86 ms
sdj: 62.00 ms
sdj: 62.20 ms
sdj: 62.75 ms
sdj: 63.33 ms
sdj: 63.50 ms
sdj: 64.00 ms
sdj: 64.50 ms
sdj: 65.33 ms
sdj: 65.67 ms
sdj: 66.20 ms
sdj: 67.20 ms
sdj: 67.33 ms
sdj: 69.33 ms
sdj: 71.00 ms
sdj: 72.33 ms
sdj: 72.50 ms
sdj: 73.20 ms
sdj: 73.67 ms
sdj: 74.50 ms
sdj: 74.67 ms
sdj: 76.71 ms
sdj: 80.50 ms
sdj: 81.00 ms
sdj: 81.50 ms
sdj: 81.67 ms
sdj: 85.40 ms
sdj: 85.50 ms
sdj: 86.80 ms
sdj: 87.17 ms
sdj: 88.00 ms
sdj: 88.20 ms
sdj: 89.00 ms
sdj: 89.67 ms
sdj: 90.67 ms
sdj: 90.75 ms
sdj: 92.50 ms
sdj: 94.00 ms
sdj: 94.50 ms
sdj: 94.75 ms
sdj: 95.75 ms
sdj: 97.25 ms
sdj: 97.75 ms
sdj: 98.50 ms
sdj: 99.00 ms
sdj: 99.50 ms
sdk: 104.25 ms
sdk: 104.75 ms
sdk: 105.50 ms
sdk: 107.67 ms
sdk: 110.00 ms
sdk: 113.50 ms
sdk: 114.33 ms
sdk: 118.33 ms
sdk: 120.33 ms
sdk: 121.00 ms
sdk: 122.33 ms
sdk: 122.67 ms
sdk: 124.00 ms
sdk: 125.00 ms
sdk: 125.33 ms
sdk: 127.67 ms
sdk: 144.33 ms
sdk: 144.67 ms
sdk: 146.00 ms
sdk: 163.00 ms
sdk: 168.50 ms
sdk: 183.00 ms
sdk: 188.00 ms
sdk: 220.00 ms
sdk: 50.33 ms
sdk: 51.00 ms
sdk: 51.25 ms
sdk: 51.33 ms
sdk: 52.00 ms
sdk: 52.50 ms
sdk: 53.00 ms
sdk: 53.33 ms
sdk: 53.50 ms
sdk: 53.67 ms
sdk: 53.75 ms
sdk: 55.00 ms
sdk: 55.25 ms
sdk: 55.33 ms
sdk: 55.60 ms
sdk: 57.67 ms
sdk: 58.00 ms
sdk: 58.33 ms
sdk: 58.80 ms
sdk: 59.00 ms
sdk: 59.33 ms
sdk: 60.00 ms
sdk: 60.50 ms
sdk: 61.00 ms
sdk: 61.33 ms
sdk: 61.80 ms
sdk: 62.33 ms
sdk: 63.33 ms
sdk: 63.80 ms
sdk: 65.00 ms
sdk: 67.00 ms
sdk: 67.67 ms
sdk: 68.67 ms
sdk: 73.50 ms
sdk: 73.67 ms
sdk: 77.50 ms
sdk: 77.60 ms
sdk: 79.00 ms
sdk: 81.25 ms
sdk: 81.50 ms
sdk: 84.17 ms
sdk: 86.80 ms
sdk: 87.00 ms
sdk: 90.25 ms
sdk: 91.50 ms
sdk: 92.25 ms
sdk: 93.00 ms
sdk: 93.75 ms
sdk: 94.00 ms
sdk: 95.67 ms
sdk: 96.00 ms
sdl: 100.75 ms
sdl: 101.00 ms
sdl: 102.25 ms
sdl: 103.00 ms
sdl: 103.50 ms
sdl: 105.50 ms
sdl: 106.00 ms
sdl: 106.50 ms
sdl: 106.75 ms
sdl: 108.00 ms
sdl: 110.00 ms
sdl: 111.75 ms
sdl: 112.00 ms
sdl: 115.67 ms
sdl: 116.80 ms
sdl: 119.67 ms
sdl: 121.00 ms
sdl: 121.33 ms
sdl: 121.67 ms
sdl: 122.00 ms
sdl: 123.00 ms
sdl: 123.67 ms
sdl: 124.67 ms
sdl: 129.00 ms
sdl: 132.00 ms
sdl: 134.00 ms
sdl: 148.00 ms
sdl: 158.50 ms
sdl: 159.00 ms
sdl: 171.00 ms
sdl: 171.50 ms
sdl: 183.00 ms
sdl: 193.00 ms
sdl: 209.00 ms
sdl: 51.00 ms
sdl: 51.50 ms
sdl: 52.20 ms
sdl: 52.80 ms
sdl: 53.00 ms
sdl: 54.00 ms
sdl: 54.25 ms
sdl: 54.33 ms
sdl: 54.50 ms
sdl: 54.67 ms
sdl: 55.25 ms
sdl: 55.67 ms
sdl: 55.75 ms
sdl: 56.67 ms
sdl: 57.00 ms
sdl: 57.33 ms
sdl: 57.75 ms
sdl: 59.00 ms
sdl: 60.67 ms
sdl: 61.00 ms
sdl: 63.00 ms
sdl: 63.33 ms
sdl: 63.67 ms
sdl: 65.00 ms
sdl: 66.00 ms
sdl: 68.83 ms
sdl: 74.33 ms
sdl: 75.20 ms
sdl: 75.67 ms
sdl: 77.83 ms
sdl: 81.50 ms
sdl: 82.17 ms
sdl: 82.80 ms
sdl: 83.20 ms
sdl: 84.67 ms
sdl: 88.60 ms
sdl: 92.75 ms
sdl: 95.75 ms
sdl: 98.00 ms
sdl: 98.50 ms
sdl: 99.25 ms
```

---

### 网络问题分析

⚠ **检测到网络问题**

**重传统计：**
    44489 segments retransmitted
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

