# Ceph 性能瓶颈分析报告

**分析时间**: 2025-12-04 13:54:27
**监控数据目录**: /home/ubuntu/intel-900p-hdd/rbd0/20251204_134653/ceph-monitoring

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
dm-17: 92.30%
dm-3: 98.30%
rbd0: 100.00%
rbd0: 100.10%
rbd0: 100.20%
rbd0: 97.70%
rbd0: 97.90%
rbd0: 98.10%
rbd0: 98.40%
rbd0: 98.60%
rbd0: 98.80%
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
sdb: 98.30%
sdd: 92.20%
```

**建议**: 高利用率磁盘可能成为瓶颈，检查是否为慢盘或负载不均。

**⚠ 检测到高延迟磁盘（await > 50ms）：**
```
sda: 100.75 ms
sda: 106.00 ms
sda: 108.00 ms
sda: 123.00 ms
sda: 149.00 ms
sda: 167.33 ms
sda: 169.00 ms
sda: 171.00 ms
sda: 199.00 ms
sda: 50.29 ms
sda: 50.40 ms
sda: 50.75 ms
sda: 51.12 ms
sda: 51.50 ms
sda: 51.67 ms
sda: 51.78 ms
sda: 52.14 ms
sda: 52.17 ms
sda: 52.29 ms
sda: 53.00 ms
sda: 54.22 ms
sda: 54.25 ms
sda: 54.33 ms
sda: 54.40 ms
sda: 54.71 ms
sda: 54.75 ms
sda: 55.00 ms
sda: 55.25 ms
sda: 55.33 ms
sda: 55.50 ms
sda: 55.71 ms
sda: 56.00 ms
sda: 57.14 ms
sda: 58.11 ms
sda: 58.12 ms
sda: 58.20 ms
sda: 58.25 ms
sda: 58.29 ms
sda: 58.56 ms
sda: 58.57 ms
sda: 59.71 ms
sda: 59.75 ms
sda: 59.80 ms
sda: 59.83 ms
sda: 60.17 ms
sda: 60.80 ms
sda: 61.50 ms
sda: 61.57 ms
sda: 62.17 ms
sda: 62.20 ms
sda: 63.17 ms
sda: 63.25 ms
sda: 63.50 ms
sda: 63.60 ms
sda: 63.62 ms
sda: 63.75 ms
sda: 64.67 ms
sda: 65.00 ms
sda: 65.60 ms
sda: 66.00 ms
sda: 66.50 ms
sda: 67.17 ms
sda: 69.25 ms
sda: 70.20 ms
sda: 70.80 ms
sda: 71.00 ms
sda: 71.17 ms
sda: 71.25 ms
sda: 71.33 ms
sda: 71.40 ms
sda: 71.57 ms
sda: 72.33 ms
sda: 73.20 ms
sda: 73.80 ms
sda: 77.25 ms
sda: 78.00 ms
sda: 78.17 ms
sda: 78.20 ms
sda: 79.00 ms
sda: 80.00 ms
sda: 81.60 ms
sda: 81.67 ms
sda: 83.67 ms
sda: 84.25 ms
sda: 84.86 ms
sda: 89.40 ms
sda: 93.75 ms
sda: 95.00 ms
sda: 95.25 ms
sda: 95.40 ms
sda: 96.20 ms
sda: 98.00 ms
sda: 99.20 ms
sdb: 101.50 ms
sdb: 102.00 ms
sdb: 102.25 ms
sdb: 105.00 ms
sdb: 107.00 ms
sdb: 109.25 ms
sdb: 115.00 ms
sdb: 119.33 ms
sdb: 122.00 ms
sdb: 131.67 ms
sdb: 132.75 ms
sdb: 152.00 ms
sdb: 159.00 ms
sdb: 165.00 ms
sdb: 168.00 ms
sdb: 187.00 ms
sdb: 188.00 ms
sdb: 197.00 ms
sdb: 209.00 ms
sdb: 210.00 ms
sdb: 50.20 ms
sdb: 50.25 ms
sdb: 50.71 ms
sdb: 50.75 ms
sdb: 50.86 ms
sdb: 51.33 ms
sdb: 51.40 ms
sdb: 51.83 ms
sdb: 52.00 ms
sdb: 52.20 ms
sdb: 52.33 ms
sdb: 52.50 ms
sdb: 52.60 ms
sdb: 53.00 ms
sdb: 53.20 ms
sdb: 53.25 ms
sdb: 53.75 ms
sdb: 53.80 ms
sdb: 54.20 ms
sdb: 54.25 ms
sdb: 55.29 ms
sdb: 55.75 ms
sdb: 56.00 ms
sdb: 56.20 ms
sdb: 56.75 ms
sdb: 57.20 ms
sdb: 57.40 ms
sdb: 57.75 ms
sdb: 58.14 ms
sdb: 58.57 ms
sdb: 59.17 ms
sdb: 59.25 ms
sdb: 60.50 ms
sdb: 60.75 ms
sdb: 61.00 ms
sdb: 61.40 ms
sdb: 61.60 ms
sdb: 62.00 ms
sdb: 63.50 ms
sdb: 63.67 ms
sdb: 64.00 ms
sdb: 64.33 ms
sdb: 64.75 ms
sdb: 65.75 ms
sdb: 66.57 ms
sdb: 66.75 ms
sdb: 66.86 ms
sdb: 67.50 ms
sdb: 67.67 ms
sdb: 68.29 ms
sdb: 68.67 ms
sdb: 69.00 ms
sdb: 69.33 ms
sdb: 69.50 ms
sdb: 69.67 ms
sdb: 70.40 ms
sdb: 70.57 ms
sdb: 71.33 ms
sdb: 71.43 ms
sdb: 72.40 ms
sdb: 73.25 ms
sdb: 73.33 ms
sdb: 73.75 ms
sdb: 74.00 ms
sdb: 75.00 ms
sdb: 75.33 ms
sdb: 76.20 ms
sdb: 76.60 ms
sdb: 77.50 ms
sdb: 77.60 ms
sdb: 79.20 ms
sdb: 80.00 ms
sdb: 80.33 ms
sdb: 84.33 ms
sdb: 89.33 ms
sdb: 91.50 ms
sdb: 92.50 ms
sdb: 96.00 ms
sdb: 99.33 ms
sdc: 101.00 ms
sdc: 102.67 ms
sdc: 103.67 ms
sdc: 114.67 ms
sdc: 121.00 ms
sdc: 131.33 ms
sdc: 149.67 ms
sdc: 165.00 ms
sdc: 176.00 ms
sdc: 50.17 ms
sdc: 50.40 ms
sdc: 50.50 ms
sdc: 50.75 ms
sdc: 50.80 ms
sdc: 50.83 ms
sdc: 51.29 ms
sdc: 51.80 ms
sdc: 52.20 ms
sdc: 52.50 ms
sdc: 52.67 ms
sdc: 53.00 ms
sdc: 53.60 ms
sdc: 54.00 ms
sdc: 54.33 ms
sdc: 54.40 ms
sdc: 54.50 ms
sdc: 54.86 ms
sdc: 56.00 ms
sdc: 56.20 ms
sdc: 56.25 ms
sdc: 56.33 ms
sdc: 56.75 ms
sdc: 57.33 ms
sdc: 57.80 ms
sdc: 57.83 ms
sdc: 57.89 ms
sdc: 58.00 ms
sdc: 58.50 ms
sdc: 59.33 ms
sdc: 59.75 ms
sdc: 60.25 ms
sdc: 60.67 ms
sdc: 60.80 ms
sdc: 61.50 ms
sdc: 61.86 ms
sdc: 62.00 ms
sdc: 63.57 ms
sdc: 64.00 ms
sdc: 64.71 ms
sdc: 65.80 ms
sdc: 66.25 ms
sdc: 67.00 ms
sdc: 67.50 ms
sdc: 68.33 ms
sdc: 69.40 ms
sdc: 70.80 ms
sdc: 70.83 ms
sdc: 72.20 ms
sdc: 74.83 ms
sdc: 75.57 ms
sdc: 77.00 ms
sdc: 78.67 ms
sdc: 80.33 ms
sdc: 81.00 ms
sdc: 82.50 ms
sdc: 82.57 ms
sdc: 84.33 ms
sdc: 84.67 ms
sdc: 86.86 ms
sdc: 91.00 ms
sdc: 91.25 ms
sdc: 94.67 ms
sdd: 103.00 ms
sdd: 105.00 ms
sdd: 106.00 ms
sdd: 109.00 ms
sdd: 113.00 ms
sdd: 147.00 ms
sdd: 148.00 ms
sdd: 150.00 ms
sdd: 162.00 ms
sdd: 169.00 ms
sdd: 190.00 ms
sdd: 50.33 ms
sdd: 50.57 ms
sdd: 50.71 ms
sdd: 50.80 ms
sdd: 50.83 ms
sdd: 51.00 ms
sdd: 51.14 ms
sdd: 51.17 ms
sdd: 51.33 ms
sdd: 51.40 ms
sdd: 52.00 ms
sdd: 52.75 ms
sdd: 53.00 ms
sdd: 54.00 ms
sdd: 54.67 ms
sdd: 54.83 ms
sdd: 55.00 ms
sdd: 55.80 ms
sdd: 56.50 ms
sdd: 56.80 ms
sdd: 56.83 ms
sdd: 57.00 ms
sdd: 57.20 ms
sdd: 57.50 ms
sdd: 57.60 ms
sdd: 57.75 ms
sdd: 58.00 ms
sdd: 58.17 ms
sdd: 58.25 ms
sdd: 58.43 ms
sdd: 58.57 ms
sdd: 58.78 ms
sdd: 58.80 ms
sdd: 59.00 ms
sdd: 59.75 ms
sdd: 59.83 ms
sdd: 60.25 ms
sdd: 60.78 ms
sdd: 61.00 ms
sdd: 61.50 ms
sdd: 61.75 ms
sdd: 61.86 ms
sdd: 62.00 ms
sdd: 62.43 ms
sdd: 62.86 ms
sdd: 63.67 ms
sdd: 64.00 ms
sdd: 64.56 ms
sdd: 64.75 ms
sdd: 65.17 ms
sdd: 65.20 ms
sdd: 65.25 ms
sdd: 65.88 ms
sdd: 67.33 ms
sdd: 68.25 ms
sdd: 68.75 ms
sdd: 69.00 ms
sdd: 69.25 ms
sdd: 69.86 ms
sdd: 71.83 ms
sdd: 73.50 ms
sdd: 73.67 ms
sdd: 74.00 ms
sdd: 76.67 ms
sdd: 78.33 ms
sdd: 78.50 ms
sdd: 79.40 ms
sdd: 80.00 ms
sdd: 82.00 ms
sdd: 93.25 ms
sde: 106.00 ms
sde: 107.75 ms
sde: 114.67 ms
sde: 115.00 ms
sde: 119.00 ms
sde: 140.33 ms
sde: 153.00 ms
sde: 170.00 ms
sde: 191.00 ms
sde: 50.40 ms
sde: 50.80 ms
sde: 51.25 ms
sde: 51.40 ms
sde: 51.44 ms
sde: 52.00 ms
sde: 52.20 ms
sde: 52.60 ms
sde: 52.67 ms
sde: 52.83 ms
sde: 53.11 ms
sde: 53.20 ms
sde: 53.40 ms
sde: 54.20 ms
sde: 54.50 ms
sde: 54.80 ms
sde: 55.20 ms
sde: 55.43 ms
sde: 55.50 ms
sde: 55.80 ms
sde: 56.50 ms
sde: 56.57 ms
sde: 57.50 ms
sde: 58.00 ms
sde: 58.14 ms
sde: 59.25 ms
sde: 59.50 ms
sde: 59.86 ms
sde: 60.00 ms
sde: 60.75 ms
sde: 61.50 ms
sde: 61.75 ms
sde: 63.33 ms
sde: 64.00 ms
sde: 64.57 ms
sde: 64.67 ms
sde: 64.75 ms
sde: 65.00 ms
sde: 65.29 ms
sde: 67.00 ms
sde: 67.29 ms
sde: 67.50 ms
sde: 68.00 ms
sde: 70.50 ms
sde: 70.83 ms
sde: 72.00 ms
sde: 72.40 ms
sde: 72.67 ms
sde: 72.75 ms
sde: 73.20 ms
sde: 75.00 ms
sde: 77.33 ms
sde: 77.50 ms
sde: 77.80 ms
sde: 78.00 ms
sde: 78.17 ms
sde: 79.40 ms
sde: 80.50 ms
sde: 82.00 ms
sde: 82.40 ms
sde: 82.67 ms
sde: 85.00 ms
sde: 85.25 ms
sde: 85.60 ms
sde: 88.20 ms
sde: 89.60 ms
sde: 91.50 ms
sde: 92.75 ms
sde: 93.00 ms
sde: 95.25 ms
sdf: 104.80 ms
sdf: 121.00 ms
sdf: 127.67 ms
sdf: 161.50 ms
sdf: 172.00 ms
sdf: 178.00 ms
sdf: 50.50 ms
sdf: 50.86 ms
sdf: 51.20 ms
sdf: 51.33 ms
sdf: 51.60 ms
sdf: 52.20 ms
sdf: 53.00 ms
sdf: 53.50 ms
sdf: 53.60 ms
sdf: 54.00 ms
sdf: 54.20 ms
sdf: 54.22 ms
sdf: 54.75 ms
sdf: 54.86 ms
sdf: 55.22 ms
sdf: 55.40 ms
sdf: 55.50 ms
sdf: 55.75 ms
sdf: 56.50 ms
sdf: 56.57 ms
sdf: 57.00 ms
sdf: 57.40 ms
sdf: 57.67 ms
sdf: 58.00 ms
sdf: 59.12 ms
sdf: 59.20 ms
sdf: 59.67 ms
sdf: 60.67 ms
sdf: 63.00 ms
sdf: 63.17 ms
sdf: 63.20 ms
sdf: 63.50 ms
sdf: 66.20 ms
sdf: 66.33 ms
sdf: 67.57 ms
sdf: 67.67 ms
sdf: 68.67 ms
sdf: 70.00 ms
sdf: 70.29 ms
sdf: 72.00 ms
sdf: 73.20 ms
sdf: 73.83 ms
sdf: 74.33 ms
sdf: 75.33 ms
sdf: 77.25 ms
sdf: 78.17 ms
sdf: 80.25 ms
sdf: 80.67 ms
sdf: 82.67 ms
sdf: 83.00 ms
sdf: 84.25 ms
sdf: 88.00 ms
sdf: 88.75 ms
sdf: 89.00 ms
sdf: 90.75 ms
sdf: 92.50 ms
sdf: 93.50 ms
sdf: 93.75 ms
sdf: 94.50 ms
sdf: 94.67 ms
sdf: 95.50 ms
sdf: 98.00 ms
sdf: 98.50 ms
sdf: 99.50 ms
sdg: 100.00 ms
sdg: 100.50 ms
sdg: 101.33 ms
sdg: 103.75 ms
sdg: 106.50 ms
sdg: 107.00 ms
sdg: 115.33 ms
sdg: 135.00 ms
sdg: 149.00 ms
sdg: 167.00 ms
sdg: 171.00 ms
sdg: 175.00 ms
sdg: 198.00 ms
sdg: 50.29 ms
sdg: 51.17 ms
sdg: 51.25 ms
sdg: 51.50 ms
sdg: 51.67 ms
sdg: 51.75 ms
sdg: 52.00 ms
sdg: 52.80 ms
sdg: 52.83 ms
sdg: 53.38 ms
sdg: 54.00 ms
sdg: 54.12 ms
sdg: 54.50 ms
sdg: 54.60 ms
sdg: 54.67 ms
sdg: 54.71 ms
sdg: 55.33 ms
sdg: 55.50 ms
sdg: 55.75 ms
sdg: 55.80 ms
sdg: 56.43 ms
sdg: 56.71 ms
sdg: 57.00 ms
sdg: 58.00 ms
sdg: 58.33 ms
sdg: 58.75 ms
sdg: 58.80 ms
sdg: 59.40 ms
sdg: 59.50 ms
sdg: 60.67 ms
sdg: 61.44 ms
sdg: 61.75 ms
sdg: 62.25 ms
sdg: 62.40 ms
sdg: 62.50 ms
sdg: 62.67 ms
sdg: 63.83 ms
sdg: 64.00 ms
sdg: 65.00 ms
sdg: 65.50 ms
sdg: 65.60 ms
sdg: 66.17 ms
sdg: 66.29 ms
sdg: 66.50 ms
sdg: 66.67 ms
sdg: 67.25 ms
sdg: 67.60 ms
sdg: 68.50 ms
sdg: 69.60 ms
sdg: 69.67 ms
sdg: 69.80 ms
sdg: 70.33 ms
sdg: 70.83 ms
sdg: 71.50 ms
sdg: 71.67 ms
sdg: 71.75 ms
sdg: 71.83 ms
sdg: 73.00 ms
sdg: 73.50 ms
sdg: 74.00 ms
sdg: 74.60 ms
sdg: 75.50 ms
sdg: 76.60 ms
sdg: 77.60 ms
sdg: 79.00 ms
sdg: 79.40 ms
sdg: 80.57 ms
sdg: 81.40 ms
sdg: 81.60 ms
sdg: 81.75 ms
sdg: 85.20 ms
sdg: 86.00 ms
sdg: 88.50 ms
sdg: 90.50 ms
sdg: 91.00 ms
sdg: 91.50 ms
sdg: 92.75 ms
sdg: 97.75 ms
sdh: 113.00 ms
sdh: 114.00 ms
sdh: 133.00 ms
sdh: 134.00 ms
sdh: 155.00 ms
sdh: 162.00 ms
sdh: 173.00 ms
sdh: 50.12 ms
sdh: 50.40 ms
sdh: 50.50 ms
sdh: 51.00 ms
sdh: 51.33 ms
sdh: 51.50 ms
sdh: 51.80 ms
sdh: 52.17 ms
sdh: 52.20 ms
sdh: 52.33 ms
sdh: 52.83 ms
sdh: 53.00 ms
sdh: 53.22 ms
sdh: 53.40 ms
sdh: 53.60 ms
sdh: 53.75 ms
sdh: 53.83 ms
sdh: 54.14 ms
sdh: 54.33 ms
sdh: 54.71 ms
sdh: 54.80 ms
sdh: 55.50 ms
sdh: 56.80 ms
sdh: 57.12 ms
sdh: 57.14 ms
sdh: 57.17 ms
sdh: 57.38 ms
sdh: 57.67 ms
sdh: 58.17 ms
sdh: 58.75 ms
sdh: 59.00 ms
sdh: 59.25 ms
sdh: 59.50 ms
sdh: 60.17 ms
sdh: 60.60 ms
sdh: 60.80 ms
sdh: 61.00 ms
sdh: 61.33 ms
sdh: 61.50 ms
sdh: 62.17 ms
sdh: 62.20 ms
sdh: 62.67 ms
sdh: 63.33 ms
sdh: 63.80 ms
sdh: 64.50 ms
sdh: 65.29 ms
sdh: 65.67 ms
sdh: 65.75 ms
sdh: 66.50 ms
sdh: 66.71 ms
sdh: 67.17 ms
sdh: 69.57 ms
sdh: 69.67 ms
sdh: 72.00 ms
sdh: 72.20 ms
sdh: 73.60 ms
sdh: 75.50 ms
sdh: 77.00 ms
sdh: 79.00 ms
sdh: 80.20 ms
sdh: 81.00 ms
sdh: 83.20 ms
sdh: 84.67 ms
sdh: 85.20 ms
sdh: 86.00 ms
sdh: 86.60 ms
sdh: 88.00 ms
sdh: 89.20 ms
sdh: 91.57 ms
sdh: 93.25 ms
sdh: 94.50 ms
sdi: 101.00 ms
sdi: 105.75 ms
sdi: 106.00 ms
sdi: 106.67 ms
sdi: 108.00 ms
sdi: 111.33 ms
sdi: 117.67 ms
sdi: 121.75 ms
sdi: 123.67 ms
sdi: 127.00 ms
sdi: 138.00 ms
sdi: 160.00 ms
sdi: 170.00 ms
sdi: 182.00 ms
sdi: 193.00 ms
sdi: 50.75 ms
sdi: 51.17 ms
sdi: 51.20 ms
sdi: 51.60 ms
sdi: 51.75 ms
sdi: 51.88 ms
sdi: 52.25 ms
sdi: 52.50 ms
sdi: 52.80 ms
sdi: 53.75 ms
sdi: 53.80 ms
sdi: 53.86 ms
sdi: 54.00 ms
sdi: 54.20 ms
sdi: 54.50 ms
sdi: 54.80 ms
sdi: 55.00 ms
sdi: 55.25 ms
sdi: 55.38 ms
sdi: 56.00 ms
sdi: 56.40 ms
sdi: 56.57 ms
sdi: 57.50 ms
sdi: 58.17 ms
sdi: 58.50 ms
sdi: 58.83 ms
sdi: 59.00 ms
sdi: 59.17 ms
sdi: 60.00 ms
sdi: 61.00 ms
sdi: 62.00 ms
sdi: 62.33 ms
sdi: 63.00 ms
sdi: 63.43 ms
sdi: 64.00 ms
sdi: 64.12 ms
sdi: 64.25 ms
sdi: 64.29 ms
sdi: 64.33 ms
sdi: 64.60 ms
sdi: 66.00 ms
sdi: 67.33 ms
sdi: 67.83 ms
sdi: 68.67 ms
sdi: 69.00 ms
sdi: 69.60 ms
sdi: 71.80 ms
sdi: 72.00 ms
sdi: 73.00 ms
sdi: 74.14 ms
sdi: 74.33 ms
sdi: 74.67 ms
sdi: 75.75 ms
sdi: 76.67 ms
sdi: 77.14 ms
sdi: 77.80 ms
sdi: 79.00 ms
sdi: 80.20 ms
sdi: 81.40 ms
sdi: 82.60 ms
sdi: 83.25 ms
sdi: 84.50 ms
sdi: 85.67 ms
sdi: 85.80 ms
sdi: 87.17 ms
sdi: 88.00 ms
sdi: 91.50 ms
sdi: 92.25 ms
sdi: 93.00 ms
sdi: 94.00 ms
sdi: 95.75 ms
sdi: 96.14 ms
sdj: 100.00 ms
sdj: 104.67 ms
sdj: 104.75 ms
sdj: 106.50 ms
sdj: 108.00 ms
sdj: 118.00 ms
sdj: 129.67 ms
sdj: 141.00 ms
sdj: 157.67 ms
sdj: 168.67 ms
sdj: 50.20 ms
sdj: 50.22 ms
sdj: 50.40 ms
sdj: 50.75 ms
sdj: 51.00 ms
sdj: 51.11 ms
sdj: 51.40 ms
sdj: 51.60 ms
sdj: 51.80 ms
sdj: 52.20 ms
sdj: 52.25 ms
sdj: 53.00 ms
sdj: 53.17 ms
sdj: 53.38 ms
sdj: 53.62 ms
sdj: 53.75 ms
sdj: 54.17 ms
sdj: 54.25 ms
sdj: 54.33 ms
sdj: 54.80 ms
sdj: 54.86 ms
sdj: 55.25 ms
sdj: 55.29 ms
sdj: 55.75 ms
sdj: 56.00 ms
sdj: 56.25 ms
sdj: 56.67 ms
sdj: 57.25 ms
sdj: 57.67 ms
sdj: 59.00 ms
sdj: 59.29 ms
sdj: 59.57 ms
sdj: 60.00 ms
sdj: 60.50 ms
sdj: 60.67 ms
sdj: 60.75 ms
sdj: 61.12 ms
sdj: 61.83 ms
sdj: 62.33 ms
sdj: 62.80 ms
sdj: 63.75 ms
sdj: 64.29 ms
sdj: 65.29 ms
sdj: 65.50 ms
sdj: 67.00 ms
sdj: 67.40 ms
sdj: 72.00 ms
sdj: 74.00 ms
sdj: 78.40 ms
sdj: 80.00 ms
sdj: 80.75 ms
sdj: 81.33 ms
sdj: 81.67 ms
sdj: 83.20 ms
sdj: 84.33 ms
sdj: 91.00 ms
sdj: 91.40 ms
sdj: 92.00 ms
sdj: 93.00 ms
sdj: 93.50 ms
sdj: 97.00 ms
sdk: 100.00 ms
sdk: 109.50 ms
sdk: 128.33 ms
sdk: 136.00 ms
sdk: 143.00 ms
sdk: 146.00 ms
sdk: 161.00 ms
sdk: 174.00 ms
sdk: 181.00 ms
sdk: 50.20 ms
sdk: 50.33 ms
sdk: 51.00 ms
sdk: 51.40 ms
sdk: 51.60 ms
sdk: 51.67 ms
sdk: 51.78 ms
sdk: 52.33 ms
sdk: 52.83 ms
sdk: 53.70 ms
sdk: 54.00 ms
sdk: 54.50 ms
sdk: 54.60 ms
sdk: 54.62 ms
sdk: 54.80 ms
sdk: 55.40 ms
sdk: 56.55 ms
sdk: 56.67 ms
sdk: 56.75 ms
sdk: 56.83 ms
sdk: 56.86 ms
sdk: 57.25 ms
sdk: 57.40 ms
sdk: 57.50 ms
sdk: 57.60 ms
sdk: 58.25 ms
sdk: 58.75 ms
sdk: 58.83 ms
sdk: 59.33 ms
sdk: 60.25 ms
sdk: 60.80 ms
sdk: 61.00 ms
sdk: 62.00 ms
sdk: 62.50 ms
sdk: 63.40 ms
sdk: 63.80 ms
sdk: 64.00 ms
sdk: 65.50 ms
sdk: 65.83 ms
sdk: 66.50 ms
sdk: 67.00 ms
sdk: 68.17 ms
sdk: 69.00 ms
sdk: 69.17 ms
sdk: 70.00 ms
sdk: 70.33 ms
sdk: 70.60 ms
sdk: 71.67 ms
sdk: 72.83 ms
sdk: 73.33 ms
sdk: 76.40 ms
sdk: 77.60 ms
sdk: 78.80 ms
sdk: 81.00 ms
sdk: 84.80 ms
sdk: 85.50 ms
sdk: 86.25 ms
sdk: 86.40 ms
sdk: 86.50 ms
sdk: 88.00 ms
sdk: 89.00 ms
sdk: 91.50 ms
sdk: 95.00 ms
sdk: 96.00 ms
sdk: 99.80 ms
sdl: 100.00 ms
sdl: 103.25 ms
sdl: 105.67 ms
sdl: 106.67 ms
sdl: 112.00 ms
sdl: 112.67 ms
sdl: 116.00 ms
sdl: 135.00 ms
sdl: 143.00 ms
sdl: 147.00 ms
sdl: 151.00 ms
sdl: 50.20 ms
sdl: 50.40 ms
sdl: 50.57 ms
sdl: 51.38 ms
sdl: 51.40 ms
sdl: 51.83 ms
sdl: 52.00 ms
sdl: 52.17 ms
sdl: 52.20 ms
sdl: 52.40 ms
sdl: 52.60 ms
sdl: 52.75 ms
sdl: 53.60 ms
sdl: 53.80 ms
sdl: 54.00 ms
sdl: 54.17 ms
sdl: 54.20 ms
sdl: 54.60 ms
sdl: 54.80 ms
sdl: 55.00 ms
sdl: 56.10 ms
sdl: 56.25 ms
sdl: 56.62 ms
sdl: 57.14 ms
sdl: 57.20 ms
sdl: 57.50 ms
sdl: 58.00 ms
sdl: 58.80 ms
sdl: 59.00 ms
sdl: 59.25 ms
sdl: 59.75 ms
sdl: 60.75 ms
sdl: 61.00 ms
sdl: 61.20 ms
sdl: 61.60 ms
sdl: 62.00 ms
sdl: 62.29 ms
sdl: 62.40 ms
sdl: 62.50 ms
sdl: 63.67 ms
sdl: 64.33 ms
sdl: 68.33 ms
sdl: 68.40 ms
sdl: 69.33 ms
sdl: 69.50 ms
sdl: 70.50 ms
sdl: 72.00 ms
sdl: 72.67 ms
sdl: 73.20 ms
sdl: 75.00 ms
sdl: 75.80 ms
sdl: 77.67 ms
sdl: 79.00 ms
sdl: 80.33 ms
sdl: 81.00 ms
sdl: 82.00 ms
sdl: 83.60 ms
sdl: 84.00 ms
sdl: 84.50 ms
sdl: 87.00 ms
sdl: 90.00 ms
sdl: 91.00 ms
sdl: 91.50 ms
sdl: 94.00 ms
sdl: 95.50 ms
sdl: 99.25 ms
```

---

### 网络问题分析

⚠ **检测到网络问题**

**重传统计：**
    47003 segments retransmitted
    31321 fast retransmits
    671 retransmits in slow start

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

⚠ **检测到 374 条内核 I/O 相关错误**

**最近错误样本（最后 10 条）：**
```
[Tue Dec  2 14:07:17 2025] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[Tue Dec  2 14:07:17 2025] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[Tue Dec  2 14:07:17 2025] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[Tue Dec  2 14:09:20 2025] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[Tue Dec  2 14:09:20 2025] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[Tue Dec  2 14:09:20 2025] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[Wed Dec  3 19:42:54 2025] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[Wed Dec  3 19:44:57 2025] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[Wed Dec  3 19:44:57 2025] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[Wed Dec  3 19:44:57 2025] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
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

