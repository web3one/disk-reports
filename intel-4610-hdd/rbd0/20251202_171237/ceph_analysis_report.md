# Ceph 性能瓶颈分析报告

**分析时间**: 2025-12-02 17:20:11
**监控数据目录**: /home/ubuntu/intel-4610-hdd/rbd0/20251202_171237/ceph-monitoring

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
rbd0: 27763.10%
rbd0: 90.10%
rbd0: 90.30%
rbd0: 90.50%
rbd0: 90.60%
rbd0: 90.80%
rbd0: 91.00%
rbd0: 91.40%
rbd0: 91.50%
rbd0: 91.60%
rbd0: 91.70%
rbd0: 91.90%
rbd0: 92.40%
rbd0: 92.60%
rbd0: 93.40%
rbd0: 96.30%
rbd0: 96.40%
rbd0: 96.50%
rbd0: 96.60%
rbd0: 96.90%
rbd0: 97.00%
rbd0: 97.10%
rbd0: 97.20%
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
rbd0: 98.91%
rbd0: 99.00%
rbd0: 99.10%
rbd0: 99.20%
rbd0: 99.30%
rbd0: 99.50%
rbd0: 99.80%
rbd0: 99.90%
```

**建议**: 高利用率磁盘可能成为瓶颈，检查是否为慢盘或负载不均。

**⚠ 检测到高延迟磁盘（await > 50ms）：**
```
sda: 100.00 ms
sda: 100.75 ms
sda: 101.00 ms
sda: 101.50 ms
sda: 101.75 ms
sda: 102.00 ms
sda: 102.43 ms
sda: 103.00 ms
sda: 104.75 ms
sda: 105.50 ms
sda: 106.25 ms
sda: 108.00 ms
sda: 109.00 ms
sda: 112.00 ms
sda: 113.17 ms
sda: 114.67 ms
sda: 116.00 ms
sda: 118.50 ms
sda: 119.00 ms
sda: 119.67 ms
sda: 121.33 ms
sda: 121.67 ms
sda: 122.33 ms
sda: 122.50 ms
sda: 124.83 ms
sda: 125.00 ms
sda: 127.00 ms
sda: 128.00 ms
sda: 132.67 ms
sda: 141.00 ms
sda: 141.25 ms
sda: 175.00 ms
sda: 190.00 ms
sda: 50.17 ms
sda: 50.50 ms
sda: 50.75 ms
sda: 51.00 ms
sda: 52.00 ms
sda: 52.40 ms
sda: 52.75 ms
sda: 53.00 ms
sda: 53.40 ms
sda: 53.83 ms
sda: 54.33 ms
sda: 54.67 ms
sda: 54.75 ms
sda: 56.00 ms
sda: 56.60 ms
sda: 56.67 ms
sda: 57.00 ms
sda: 57.50 ms
sda: 59.00 ms
sda: 60.00 ms
sda: 60.25 ms
sda: 60.80 ms
sda: 60.83 ms
sda: 61.00 ms
sda: 62.00 ms
sda: 63.67 ms
sda: 64.25 ms
sda: 65.00 ms
sda: 66.00 ms
sda: 66.71 ms
sda: 68.50 ms
sda: 69.75 ms
sda: 70.17 ms
sda: 70.86 ms
sda: 71.17 ms
sda: 72.20 ms
sda: 74.00 ms
sda: 74.17 ms
sda: 74.50 ms
sda: 74.57 ms
sda: 74.83 ms
sda: 75.00 ms
sda: 76.00 ms
sda: 77.00 ms
sda: 77.60 ms
sda: 77.80 ms
sda: 78.40 ms
sda: 78.60 ms
sda: 79.40 ms
sda: 80.40 ms
sda: 80.71 ms
sda: 81.33 ms
sda: 82.17 ms
sda: 82.38 ms
sda: 82.60 ms
sda: 83.75 ms
sda: 83.83 ms
sda: 84.60 ms
sda: 84.75 ms
sda: 84.83 ms
sda: 85.80 ms
sda: 86.50 ms
sda: 86.75 ms
sda: 87.25 ms
sda: 88.00 ms
sda: 88.25 ms
sda: 88.75 ms
sda: 93.50 ms
sda: 93.75 ms
sda: 94.25 ms
sda: 94.75 ms
sda: 95.00 ms
sda: 95.17 ms
sda: 95.25 ms
sda: 95.75 ms
sda: 96.00 ms
sda: 96.50 ms
sda: 96.67 ms
sda: 96.75 ms
sda: 97.25 ms
sda: 98.00 ms
sda: 99.25 ms
sda: 99.50 ms
sda: 99.75 ms
sda: 99.83 ms
sdb: 100.50 ms
sdb: 102.50 ms
sdb: 103.00 ms
sdb: 104.50 ms
sdb: 107.25 ms
sdb: 108.00 ms
sdb: 110.14 ms
sdb: 112.33 ms
sdb: 113.50 ms
sdb: 115.17 ms
sdb: 118.00 ms
sdb: 118.67 ms
sdb: 119.00 ms
sdb: 120.33 ms
sdb: 121.83 ms
sdb: 123.67 ms
sdb: 124.00 ms
sdb: 127.00 ms
sdb: 128.33 ms
sdb: 128.40 ms
sdb: 129.00 ms
sdb: 131.33 ms
sdb: 132.25 ms
sdb: 133.67 ms
sdb: 141.00 ms
sdb: 191.00 ms
sdb: 198.00 ms
sdb: 50.40 ms
sdb: 50.50 ms
sdb: 50.57 ms
sdb: 50.75 ms
sdb: 50.86 ms
sdb: 51.00 ms
sdb: 51.80 ms
sdb: 52.00 ms
sdb: 52.60 ms
sdb: 52.67 ms
sdb: 53.00 ms
sdb: 53.33 ms
sdb: 53.67 ms
sdb: 54.25 ms
sdb: 54.83 ms
sdb: 55.67 ms
sdb: 56.33 ms
sdb: 57.67 ms
sdb: 60.00 ms
sdb: 61.33 ms
sdb: 62.33 ms
sdb: 62.60 ms
sdb: 64.67 ms
sdb: 65.25 ms
sdb: 66.33 ms
sdb: 66.71 ms
sdb: 67.50 ms
sdb: 68.00 ms
sdb: 68.33 ms
sdb: 68.50 ms
sdb: 69.00 ms
sdb: 69.67 ms
sdb: 72.67 ms
sdb: 72.83 ms
sdb: 74.50 ms
sdb: 74.67 ms
sdb: 75.20 ms
sdb: 77.17 ms
sdb: 79.17 ms
sdb: 79.80 ms
sdb: 80.40 ms
sdb: 81.00 ms
sdb: 82.20 ms
sdb: 82.33 ms
sdb: 84.17 ms
sdb: 84.67 ms
sdb: 85.40 ms
sdb: 85.60 ms
sdb: 87.75 ms
sdb: 89.67 ms
sdb: 90.50 ms
sdb: 90.75 ms
sdb: 91.50 ms
sdb: 92.00 ms
sdb: 92.25 ms
sdb: 93.25 ms
sdb: 93.50 ms
sdb: 94.25 ms
sdb: 94.40 ms
sdb: 95.00 ms
sdb: 95.75 ms
sdb: 96.00 ms
sdb: 97.00 ms
sdb: 97.40 ms
sdb: 99.75 ms
sdc: 100.25 ms
sdc: 101.75 ms
sdc: 102.00 ms
sdc: 102.75 ms
sdc: 103.25 ms
sdc: 105.50 ms
sdc: 107.00 ms
sdc: 108.00 ms
sdc: 110.67 ms
sdc: 111.67 ms
sdc: 113.00 ms
sdc: 115.50 ms
sdc: 116.75 ms
sdc: 117.33 ms
sdc: 120.50 ms
sdc: 120.67 ms
sdc: 121.17 ms
sdc: 123.00 ms
sdc: 124.50 ms
sdc: 125.67 ms
sdc: 127.50 ms
sdc: 138.50 ms
sdc: 146.75 ms
sdc: 170.00 ms
sdc: 186.00 ms
sdc: 190.00 ms
sdc: 201.00 ms
sdc: 50.25 ms
sdc: 50.50 ms
sdc: 50.75 ms
sdc: 51.00 ms
sdc: 51.25 ms
sdc: 52.00 ms
sdc: 52.20 ms
sdc: 52.33 ms
sdc: 52.67 ms
sdc: 53.00 ms
sdc: 53.50 ms
sdc: 53.75 ms
sdc: 54.33 ms
sdc: 55.33 ms
sdc: 57.00 ms
sdc: 57.25 ms
sdc: 58.40 ms
sdc: 58.50 ms
sdc: 59.00 ms
sdc: 59.50 ms
sdc: 60.00 ms
sdc: 61.33 ms
sdc: 61.83 ms
sdc: 62.00 ms
sdc: 64.67 ms
sdc: 64.80 ms
sdc: 65.50 ms
sdc: 65.86 ms
sdc: 66.00 ms
sdc: 66.50 ms
sdc: 66.67 ms
sdc: 67.33 ms
sdc: 67.50 ms
sdc: 68.33 ms
sdc: 68.83 ms
sdc: 70.20 ms
sdc: 70.67 ms
sdc: 71.00 ms
sdc: 72.17 ms
sdc: 72.33 ms
sdc: 72.50 ms
sdc: 72.62 ms
sdc: 73.00 ms
sdc: 73.50 ms
sdc: 73.57 ms
sdc: 73.67 ms
sdc: 74.00 ms
sdc: 74.50 ms
sdc: 76.33 ms
sdc: 77.50 ms
sdc: 78.83 ms
sdc: 79.33 ms
sdc: 80.40 ms
sdc: 80.75 ms
sdc: 81.83 ms
sdc: 82.00 ms
sdc: 82.17 ms
sdc: 84.20 ms
sdc: 84.75 ms
sdc: 84.80 ms
sdc: 85.80 ms
sdc: 87.00 ms
sdc: 87.50 ms
sdc: 88.00 ms
sdc: 90.50 ms
sdc: 91.00 ms
sdc: 91.25 ms
sdc: 91.67 ms
sdc: 92.50 ms
sdc: 93.50 ms
sdc: 94.25 ms
sdc: 94.50 ms
sdc: 94.75 ms
sdc: 95.50 ms
sdc: 95.75 ms
sdc: 96.25 ms
sdc: 96.50 ms
sdc: 97.00 ms
sdc: 98.50 ms
sdd: 100.75 ms
sdd: 101.00 ms
sdd: 102.75 ms
sdd: 103.00 ms
sdd: 103.40 ms
sdd: 104.00 ms
sdd: 105.00 ms
sdd: 105.20 ms
sdd: 105.75 ms
sdd: 105.80 ms
sdd: 106.25 ms
sdd: 106.50 ms
sdd: 108.25 ms
sdd: 111.17 ms
sdd: 115.33 ms
sdd: 115.60 ms
sdd: 116.17 ms
sdd: 116.50 ms
sdd: 119.33 ms
sdd: 121.00 ms
sdd: 121.67 ms
sdd: 122.33 ms
sdd: 123.00 ms
sdd: 124.00 ms
sdd: 125.00 ms
sdd: 125.67 ms
sdd: 126.00 ms
sdd: 128.33 ms
sdd: 129.00 ms
sdd: 137.25 ms
sdd: 139.00 ms
sdd: 142.75 ms
sdd: 162.00 ms
sdd: 182.00 ms
sdd: 188.00 ms
sdd: 202.00 ms
sdd: 211.00 ms
sdd: 212.00 ms
sdd: 217.00 ms
sdd: 234.00 ms
sdd: 50.33 ms
sdd: 50.75 ms
sdd: 51.00 ms
sdd: 52.12 ms
sdd: 52.33 ms
sdd: 53.17 ms
sdd: 53.25 ms
sdd: 54.50 ms
sdd: 54.67 ms
sdd: 55.25 ms
sdd: 56.00 ms
sdd: 56.33 ms
sdd: 56.67 ms
sdd: 57.00 ms
sdd: 57.33 ms
sdd: 58.67 ms
sdd: 59.00 ms
sdd: 59.33 ms
sdd: 59.57 ms
sdd: 60.00 ms
sdd: 60.38 ms
sdd: 60.50 ms
sdd: 60.75 ms
sdd: 64.43 ms
sdd: 65.67 ms
sdd: 65.88 ms
sdd: 66.33 ms
sdd: 68.75 ms
sdd: 69.00 ms
sdd: 69.50 ms
sdd: 69.67 ms
sdd: 70.67 ms
sdd: 71.00 ms
sdd: 72.00 ms
sdd: 73.00 ms
sdd: 73.25 ms
sdd: 74.00 ms
sdd: 74.38 ms
sdd: 74.60 ms
sdd: 74.83 ms
sdd: 75.25 ms
sdd: 76.20 ms
sdd: 76.25 ms
sdd: 76.50 ms
sdd: 77.00 ms
sdd: 77.40 ms
sdd: 79.17 ms
sdd: 79.33 ms
sdd: 80.75 ms
sdd: 82.33 ms
sdd: 82.60 ms
sdd: 83.00 ms
sdd: 83.67 ms
sdd: 84.17 ms
sdd: 84.50 ms
sdd: 85.17 ms
sdd: 85.25 ms
sdd: 88.50 ms
sdd: 90.67 ms
sdd: 91.00 ms
sdd: 91.25 ms
sdd: 91.50 ms
sdd: 92.75 ms
sdd: 93.67 ms
sdd: 94.50 ms
sdd: 94.60 ms
sdd: 95.00 ms
sdd: 95.25 ms
sdd: 96.50 ms
sdd: 97.00 ms
sdd: 97.50 ms
sdd: 97.67 ms
sdd: 98.00 ms
sde: 100.75 ms
sde: 101.25 ms
sde: 101.50 ms
sde: 102.50 ms
sde: 104.00 ms
sde: 104.80 ms
sde: 106.00 ms
sde: 106.14 ms
sde: 108.33 ms
sde: 113.00 ms
sde: 114.00 ms
sde: 115.33 ms
sde: 117.50 ms
sde: 118.67 ms
sde: 121.00 ms
sde: 122.00 ms
sde: 124.17 ms
sde: 127.67 ms
sde: 128.00 ms
sde: 128.33 ms
sde: 132.67 ms
sde: 136.00 ms
sde: 157.00 ms
sde: 164.00 ms
sde: 193.00 ms
sde: 50.40 ms
sde: 51.20 ms
sde: 51.33 ms
sde: 51.50 ms
sde: 52.00 ms
sde: 53.50 ms
sde: 53.75 ms
sde: 54.25 ms
sde: 54.40 ms
sde: 54.75 ms
sde: 56.17 ms
sde: 56.67 ms
sde: 57.60 ms
sde: 58.25 ms
sde: 59.00 ms
sde: 59.25 ms
sde: 60.17 ms
sde: 60.83 ms
sde: 61.00 ms
sde: 63.00 ms
sde: 63.50 ms
sde: 64.20 ms
sde: 67.00 ms
sde: 68.83 ms
sde: 71.50 ms
sde: 72.00 ms
sde: 72.67 ms
sde: 73.50 ms
sde: 73.67 ms
sde: 74.40 ms
sde: 75.29 ms
sde: 76.00 ms
sde: 76.40 ms
sde: 77.60 ms
sde: 77.67 ms
sde: 78.00 ms
sde: 78.33 ms
sde: 78.67 ms
sde: 78.80 ms
sde: 79.50 ms
sde: 81.83 ms
sde: 83.00 ms
sde: 83.25 ms
sde: 83.60 ms
sde: 84.40 ms
sde: 84.60 ms
sde: 85.00 ms
sde: 89.60 ms
sde: 89.75 ms
sde: 90.75 ms
sde: 91.25 ms
sde: 92.50 ms
sde: 93.40 ms
sde: 94.00 ms
sde: 94.25 ms
sde: 95.00 ms
sde: 96.00 ms
sde: 96.25 ms
sde: 96.50 ms
sde: 97.25 ms
sde: 98.25 ms
sde: 98.50 ms
sde: 98.75 ms
sde: 99.00 ms
sdf: 100.00 ms
sdf: 100.40 ms
sdf: 100.50 ms
sdf: 101.75 ms
sdf: 102.00 ms
sdf: 102.57 ms
sdf: 103.50 ms
sdf: 103.75 ms
sdf: 104.33 ms
sdf: 105.25 ms
sdf: 105.71 ms
sdf: 110.00 ms
sdf: 110.33 ms
sdf: 113.00 ms
sdf: 114.33 ms
sdf: 114.67 ms
sdf: 116.00 ms
sdf: 117.00 ms
sdf: 118.00 ms
sdf: 119.00 ms
sdf: 119.67 ms
sdf: 121.00 ms
sdf: 122.33 ms
sdf: 122.67 ms
sdf: 123.33 ms
sdf: 125.00 ms
sdf: 125.67 ms
sdf: 132.33 ms
sdf: 136.75 ms
sdf: 138.00 ms
sdf: 143.00 ms
sdf: 164.00 ms
sdf: 204.00 ms
sdf: 50.67 ms
sdf: 50.83 ms
sdf: 51.33 ms
sdf: 51.50 ms
sdf: 51.67 ms
sdf: 52.00 ms
sdf: 52.50 ms
sdf: 52.67 ms
sdf: 52.80 ms
sdf: 53.20 ms
sdf: 53.25 ms
sdf: 53.33 ms
sdf: 54.00 ms
sdf: 54.17 ms
sdf: 54.80 ms
sdf: 55.33 ms
sdf: 59.25 ms
sdf: 60.00 ms
sdf: 60.40 ms
sdf: 60.67 ms
sdf: 62.00 ms
sdf: 62.50 ms
sdf: 63.00 ms
sdf: 63.33 ms
sdf: 64.75 ms
sdf: 64.80 ms
sdf: 66.00 ms
sdf: 69.83 ms
sdf: 72.43 ms
sdf: 74.83 ms
sdf: 77.50 ms
sdf: 78.00 ms
sdf: 78.83 ms
sdf: 80.20 ms
sdf: 81.17 ms
sdf: 83.00 ms
sdf: 83.17 ms
sdf: 85.50 ms
sdf: 87.17 ms
sdf: 87.50 ms
sdf: 87.75 ms
sdf: 88.00 ms
sdf: 88.25 ms
sdf: 89.20 ms
sdf: 90.25 ms
sdf: 91.25 ms
sdf: 91.50 ms
sdf: 92.25 ms
sdf: 92.75 ms
sdf: 93.00 ms
sdf: 93.25 ms
sdf: 93.50 ms
sdf: 94.00 ms
sdf: 94.50 ms
sdf: 95.00 ms
sdf: 95.75 ms
sdf: 96.50 ms
sdf: 96.75 ms
sdf: 97.25 ms
sdf: 97.75 ms
sdf: 99.00 ms
sdg: 100.25 ms
sdg: 101.25 ms
sdg: 102.25 ms
sdg: 105.00 ms
sdg: 108.50 ms
sdg: 109.00 ms
sdg: 109.33 ms
sdg: 110.00 ms
sdg: 112.50 ms
sdg: 114.00 ms
sdg: 120.00 ms
sdg: 120.17 ms
sdg: 120.33 ms
sdg: 120.67 ms
sdg: 121.00 ms
sdg: 124.33 ms
sdg: 131.00 ms
sdg: 143.25 ms
sdg: 145.25 ms
sdg: 180.00 ms
sdg: 182.00 ms
sdg: 186.00 ms
sdg: 206.00 ms
sdg: 50.25 ms
sdg: 50.33 ms
sdg: 50.50 ms
sdg: 50.67 ms
sdg: 51.00 ms
sdg: 52.00 ms
sdg: 52.33 ms
sdg: 52.40 ms
sdg: 52.50 ms
sdg: 53.20 ms
sdg: 54.00 ms
sdg: 55.67 ms
sdg: 56.00 ms
sdg: 56.14 ms
sdg: 56.50 ms
sdg: 57.00 ms
sdg: 57.14 ms
sdg: 58.25 ms
sdg: 58.60 ms
sdg: 59.00 ms
sdg: 59.25 ms
sdg: 62.67 ms
sdg: 63.29 ms
sdg: 64.00 ms
sdg: 64.33 ms
sdg: 64.50 ms
sdg: 64.83 ms
sdg: 66.33 ms
sdg: 66.50 ms
sdg: 67.67 ms
sdg: 68.67 ms
sdg: 70.60 ms
sdg: 71.00 ms
sdg: 71.67 ms
sdg: 73.00 ms
sdg: 74.20 ms
sdg: 74.83 ms
sdg: 75.00 ms
sdg: 75.33 ms
sdg: 75.67 ms
sdg: 75.83 ms
sdg: 76.20 ms
sdg: 77.20 ms
sdg: 77.75 ms
sdg: 79.00 ms
sdg: 79.50 ms
sdg: 79.67 ms
sdg: 80.60 ms
sdg: 80.83 ms
sdg: 81.60 ms
sdg: 82.00 ms
sdg: 85.50 ms
sdg: 87.50 ms
sdg: 88.00 ms
sdg: 89.17 ms
sdg: 89.25 ms
sdg: 89.33 ms
sdg: 90.00 ms
sdg: 90.83 ms
sdg: 91.50 ms
sdg: 91.75 ms
sdg: 92.25 ms
sdg: 92.50 ms
sdg: 92.83 ms
sdg: 93.17 ms
sdg: 94.00 ms
sdg: 94.25 ms
sdg: 96.50 ms
sdg: 96.80 ms
sdg: 98.75 ms
sdg: 99.00 ms
sdg: 99.75 ms
sdh: 100.00 ms
sdh: 100.14 ms
sdh: 100.75 ms
sdh: 101.00 ms
sdh: 101.29 ms
sdh: 101.75 ms
sdh: 103.00 ms
sdh: 103.50 ms
sdh: 104.00 ms
sdh: 105.00 ms
sdh: 106.00 ms
sdh: 108.00 ms
sdh: 109.50 ms
sdh: 112.50 ms
sdh: 114.00 ms
sdh: 114.40 ms
sdh: 115.40 ms
sdh: 115.67 ms
sdh: 116.33 ms
sdh: 117.50 ms
sdh: 118.00 ms
sdh: 118.17 ms
sdh: 119.00 ms
sdh: 120.80 ms
sdh: 123.67 ms
sdh: 124.33 ms
sdh: 124.75 ms
sdh: 126.75 ms
sdh: 130.25 ms
sdh: 131.75 ms
sdh: 132.50 ms
sdh: 133.25 ms
sdh: 141.50 ms
sdh: 147.25 ms
sdh: 150.00 ms
sdh: 151.00 ms
sdh: 160.00 ms
sdh: 170.00 ms
sdh: 198.00 ms
sdh: 50.25 ms
sdh: 50.83 ms
sdh: 51.00 ms
sdh: 51.50 ms
sdh: 51.71 ms
sdh: 51.83 ms
sdh: 52.00 ms
sdh: 52.20 ms
sdh: 52.50 ms
sdh: 53.00 ms
sdh: 53.20 ms
sdh: 53.50 ms
sdh: 53.75 ms
sdh: 54.33 ms
sdh: 54.38 ms
sdh: 54.57 ms
sdh: 54.75 ms
sdh: 55.00 ms
sdh: 55.25 ms
sdh: 55.50 ms
sdh: 56.00 ms
sdh: 56.67 ms
sdh: 57.50 ms
sdh: 58.67 ms
sdh: 59.67 ms
sdh: 60.17 ms
sdh: 60.33 ms
sdh: 61.00 ms
sdh: 61.20 ms
sdh: 61.33 ms
sdh: 63.00 ms
sdh: 63.50 ms
sdh: 65.75 ms
sdh: 66.00 ms
sdh: 68.33 ms
sdh: 69.00 ms
sdh: 70.12 ms
sdh: 70.33 ms
sdh: 70.40 ms
sdh: 71.25 ms
sdh: 71.50 ms
sdh: 71.80 ms
sdh: 72.50 ms
sdh: 72.86 ms
sdh: 73.33 ms
sdh: 73.80 ms
sdh: 73.83 ms
sdh: 74.40 ms
sdh: 74.67 ms
sdh: 75.00 ms
sdh: 75.17 ms
sdh: 76.50 ms
sdh: 78.00 ms
sdh: 78.40 ms
sdh: 79.00 ms
sdh: 79.17 ms
sdh: 79.20 ms
sdh: 80.40 ms
sdh: 80.60 ms
sdh: 81.00 ms
sdh: 81.17 ms
sdh: 81.20 ms
sdh: 83.33 ms
sdh: 83.83 ms
sdh: 84.25 ms
sdh: 87.17 ms
sdh: 87.40 ms
sdh: 87.75 ms
sdh: 88.75 ms
sdh: 89.00 ms
sdh: 89.75 ms
sdh: 90.50 ms
sdh: 90.80 ms
sdh: 91.25 ms
sdh: 91.50 ms
sdh: 91.67 ms
sdh: 92.00 ms
sdh: 92.25 ms
sdh: 92.75 ms
sdh: 93.25 ms
sdh: 93.75 ms
sdh: 94.00 ms
sdh: 94.25 ms
sdh: 95.25 ms
sdh: 95.75 ms
sdh: 96.67 ms
sdh: 97.25 ms
sdh: 97.75 ms
sdh: 98.25 ms
sdh: 98.50 ms
sdh: 99.00 ms
sdh: 99.50 ms
sdi: 100.75 ms
sdi: 101.00 ms
sdi: 101.17 ms
sdi: 102.25 ms
sdi: 103.43 ms
sdi: 104.00 ms
sdi: 105.25 ms
sdi: 107.67 ms
sdi: 107.75 ms
sdi: 112.20 ms
sdi: 112.67 ms
sdi: 114.50 ms
sdi: 115.33 ms
sdi: 116.00 ms
sdi: 116.80 ms
sdi: 117.00 ms
sdi: 117.20 ms
sdi: 118.00 ms
sdi: 119.50 ms
sdi: 120.33 ms
sdi: 124.50 ms
sdi: 125.00 ms
sdi: 126.33 ms
sdi: 127.25 ms
sdi: 127.50 ms
sdi: 131.33 ms
sdi: 147.75 ms
sdi: 149.00 ms
sdi: 151.00 ms
sdi: 174.00 ms
sdi: 50.33 ms
sdi: 50.50 ms
sdi: 50.67 ms
sdi: 51.50 ms
sdi: 51.67 ms
sdi: 51.75 ms
sdi: 52.50 ms
sdi: 53.00 ms
sdi: 53.20 ms
sdi: 53.67 ms
sdi: 53.75 ms
sdi: 54.00 ms
sdi: 54.33 ms
sdi: 54.50 ms
sdi: 55.25 ms
sdi: 56.17 ms
sdi: 56.78 ms
sdi: 57.33 ms
sdi: 57.67 ms
sdi: 58.25 ms
sdi: 58.67 ms
sdi: 59.00 ms
sdi: 59.25 ms
sdi: 60.50 ms
sdi: 63.00 ms
sdi: 63.25 ms
sdi: 64.33 ms
sdi: 65.83 ms
sdi: 66.50 ms
sdi: 67.25 ms
sdi: 70.40 ms
sdi: 70.50 ms
sdi: 70.83 ms
sdi: 71.40 ms
sdi: 74.00 ms
sdi: 74.43 ms
sdi: 74.83 ms
sdi: 75.00 ms
sdi: 75.88 ms
sdi: 76.00 ms
sdi: 76.60 ms
sdi: 76.67 ms
sdi: 77.43 ms
sdi: 78.60 ms
sdi: 78.67 ms
sdi: 78.75 ms
sdi: 79.25 ms
sdi: 79.60 ms
sdi: 79.71 ms
sdi: 79.83 ms
sdi: 80.00 ms
sdi: 80.17 ms
sdi: 80.50 ms
sdi: 81.20 ms
sdi: 83.33 ms
sdi: 83.67 ms
sdi: 83.80 ms
sdi: 84.00 ms
sdi: 85.14 ms
sdi: 85.50 ms
sdi: 85.75 ms
sdi: 86.20 ms
sdi: 86.60 ms
sdi: 86.67 ms
sdi: 87.50 ms
sdi: 87.67 ms
sdi: 88.00 ms
sdi: 88.80 ms
sdi: 90.40 ms
sdi: 90.50 ms
sdi: 92.00 ms
sdi: 92.50 ms
sdi: 93.25 ms
sdi: 93.33 ms
sdi: 94.00 ms
sdi: 95.00 ms
sdi: 95.75 ms
sdi: 96.25 ms
sdi: 97.50 ms
sdi: 98.25 ms
sdi: 99.00 ms
sdi: 99.60 ms
sdj: 100.00 ms
sdj: 100.75 ms
sdj: 101.00 ms
sdj: 102.50 ms
sdj: 103.56 ms
sdj: 104.50 ms
sdj: 105.50 ms
sdj: 106.00 ms
sdj: 109.50 ms
sdj: 110.43 ms
sdj: 111.67 ms
sdj: 111.83 ms
sdj: 112.60 ms
sdj: 113.00 ms
sdj: 113.29 ms
sdj: 114.50 ms
sdj: 114.80 ms
sdj: 116.00 ms
sdj: 116.60 ms
sdj: 117.00 ms
sdj: 118.17 ms
sdj: 118.67 ms
sdj: 119.00 ms
sdj: 120.00 ms
sdj: 120.57 ms
sdj: 123.00 ms
sdj: 123.67 ms
sdj: 126.00 ms
sdj: 134.50 ms
sdj: 137.00 ms
sdj: 141.25 ms
sdj: 145.00 ms
sdj: 148.00 ms
sdj: 153.50 ms
sdj: 155.25 ms
sdj: 158.00 ms
sdj: 161.00 ms
sdj: 214.00 ms
sdj: 50.50 ms
sdj: 51.00 ms
sdj: 51.17 ms
sdj: 53.00 ms
sdj: 53.14 ms
sdj: 53.89 ms
sdj: 54.29 ms
sdj: 55.00 ms
sdj: 55.25 ms
sdj: 55.50 ms
sdj: 56.00 ms
sdj: 56.17 ms
sdj: 56.25 ms
sdj: 57.00 ms
sdj: 57.17 ms
sdj: 58.00 ms
sdj: 59.20 ms
sdj: 59.60 ms
sdj: 59.67 ms
sdj: 59.88 ms
sdj: 60.50 ms
sdj: 60.86 ms
sdj: 61.00 ms
sdj: 61.67 ms
sdj: 62.75 ms
sdj: 64.25 ms
sdj: 64.43 ms
sdj: 64.50 ms
sdj: 66.29 ms
sdj: 67.17 ms
sdj: 68.33 ms
sdj: 69.00 ms
sdj: 69.67 ms
sdj: 69.83 ms
sdj: 69.86 ms
sdj: 70.50 ms
sdj: 71.56 ms
sdj: 72.83 ms
sdj: 74.67 ms
sdj: 75.00 ms
sdj: 75.83 ms
sdj: 76.22 ms
sdj: 76.33 ms
sdj: 76.75 ms
sdj: 77.67 ms
sdj: 78.00 ms
sdj: 78.60 ms
sdj: 78.75 ms
sdj: 79.14 ms
sdj: 79.40 ms
sdj: 79.50 ms
sdj: 81.50 ms
sdj: 82.20 ms
sdj: 82.67 ms
sdj: 83.40 ms
sdj: 83.83 ms
sdj: 84.17 ms
sdj: 84.20 ms
sdj: 84.33 ms
sdj: 84.83 ms
sdj: 85.00 ms
sdj: 85.33 ms
sdj: 85.83 ms
sdj: 86.33 ms
sdj: 88.00 ms
sdj: 90.00 ms
sdj: 90.29 ms
sdj: 91.50 ms
sdj: 91.62 ms
sdj: 92.50 ms
sdj: 93.00 ms
sdj: 93.33 ms
sdj: 93.75 ms
sdj: 94.88 ms
sdj: 96.00 ms
sdj: 96.50 ms
sdj: 97.00 ms
sdj: 97.25 ms
sdj: 97.75 ms
sdj: 98.00 ms
sdj: 98.50 ms
sdj: 99.25 ms
sdj: 99.33 ms
sdk: 100.00 ms
sdk: 100.40 ms
sdk: 100.75 ms
sdk: 101.25 ms
sdk: 103.25 ms
sdk: 104.00 ms
sdk: 104.50 ms
sdk: 105.00 ms
sdk: 106.60 ms
sdk: 109.00 ms
sdk: 111.33 ms
sdk: 112.67 ms
sdk: 114.50 ms
sdk: 115.17 ms
sdk: 118.67 ms
sdk: 119.00 ms
sdk: 119.67 ms
sdk: 120.00 ms
sdk: 120.83 ms
sdk: 121.00 ms
sdk: 124.00 ms
sdk: 128.50 ms
sdk: 133.50 ms
sdk: 134.00 ms
sdk: 142.00 ms
sdk: 145.75 ms
sdk: 187.00 ms
sdk: 203.50 ms
sdk: 50.17 ms
sdk: 50.50 ms
sdk: 51.00 ms
sdk: 51.17 ms
sdk: 51.50 ms
sdk: 52.17 ms
sdk: 52.80 ms
sdk: 53.00 ms
sdk: 53.25 ms
sdk: 53.33 ms
sdk: 53.50 ms
sdk: 55.80 ms
sdk: 56.67 ms
sdk: 57.67 ms
sdk: 58.50 ms
sdk: 59.50 ms
sdk: 60.00 ms
sdk: 60.14 ms
sdk: 61.33 ms
sdk: 61.75 ms
sdk: 62.00 ms
sdk: 63.33 ms
sdk: 63.67 ms
sdk: 64.00 ms
sdk: 64.33 ms
sdk: 66.00 ms
sdk: 67.83 ms
sdk: 68.00 ms
sdk: 69.67 ms
sdk: 69.71 ms
sdk: 70.83 ms
sdk: 71.67 ms
sdk: 72.00 ms
sdk: 72.17 ms
sdk: 72.50 ms
sdk: 73.00 ms
sdk: 73.38 ms
sdk: 73.43 ms
sdk: 74.00 ms
sdk: 74.75 ms
sdk: 75.14 ms
sdk: 75.20 ms
sdk: 76.75 ms
sdk: 77.50 ms
sdk: 77.60 ms
sdk: 78.00 ms
sdk: 78.50 ms
sdk: 79.14 ms
sdk: 79.25 ms
sdk: 79.50 ms
sdk: 81.40 ms
sdk: 82.00 ms
sdk: 82.80 ms
sdk: 83.50 ms
sdk: 84.50 ms
sdk: 85.70 ms
sdk: 86.33 ms
sdk: 87.40 ms
sdk: 87.50 ms
sdk: 88.00 ms
sdk: 88.50 ms
sdk: 89.83 ms
sdk: 90.00 ms
sdk: 91.00 ms
sdk: 91.25 ms
sdk: 91.75 ms
sdk: 92.00 ms
sdk: 92.50 ms
sdk: 92.60 ms
sdk: 92.75 ms
sdk: 93.17 ms
sdk: 94.00 ms
sdk: 94.17 ms
sdk: 94.20 ms
sdk: 94.25 ms
sdk: 95.00 ms
sdk: 95.20 ms
sdk: 95.50 ms
sdk: 96.00 ms
sdk: 97.00 ms
sdk: 98.25 ms
sdk: 98.75 ms
sdk: 99.25 ms
sdk: 99.50 ms
sdl: 100.00 ms
sdl: 100.25 ms
sdl: 101.50 ms
sdl: 104.25 ms
sdl: 104.50 ms
sdl: 105.00 ms
sdl: 106.00 ms
sdl: 107.00 ms
sdl: 108.00 ms
sdl: 108.50 ms
sdl: 110.00 ms
sdl: 110.71 ms
sdl: 111.00 ms
sdl: 112.67 ms
sdl: 113.00 ms
sdl: 113.86 ms
sdl: 116.67 ms
sdl: 119.50 ms
sdl: 119.67 ms
sdl: 120.33 ms
sdl: 121.83 ms
sdl: 123.67 ms
sdl: 126.00 ms
sdl: 126.67 ms
sdl: 127.20 ms
sdl: 128.00 ms
sdl: 128.50 ms
sdl: 131.67 ms
sdl: 134.25 ms
sdl: 218.00 ms
sdl: 50.75 ms
sdl: 51.00 ms
sdl: 52.00 ms
sdl: 52.67 ms
sdl: 54.00 ms
sdl: 54.25 ms
sdl: 55.00 ms
sdl: 55.50 ms
sdl: 57.12 ms
sdl: 57.33 ms
sdl: 58.50 ms
sdl: 58.75 ms
sdl: 59.00 ms
sdl: 59.83 ms
sdl: 60.50 ms
sdl: 62.83 ms
sdl: 63.00 ms
sdl: 65.00 ms
sdl: 66.67 ms
sdl: 68.25 ms
sdl: 68.50 ms
sdl: 68.71 ms
sdl: 69.25 ms
sdl: 70.33 ms
sdl: 70.67 ms
sdl: 72.00 ms
sdl: 74.00 ms
sdl: 74.83 ms
sdl: 75.67 ms
sdl: 75.83 ms
sdl: 76.00 ms
sdl: 77.17 ms
sdl: 78.00 ms
sdl: 78.50 ms
sdl: 78.75 ms
sdl: 78.83 ms
sdl: 80.00 ms
sdl: 80.60 ms
sdl: 82.33 ms
sdl: 83.25 ms
sdl: 84.00 ms
sdl: 84.60 ms
sdl: 85.50 ms
sdl: 85.60 ms
sdl: 86.29 ms
sdl: 88.75 ms
sdl: 89.00 ms
sdl: 89.50 ms
sdl: 89.75 ms
sdl: 91.00 ms
sdl: 91.25 ms
sdl: 91.33 ms
sdl: 91.67 ms
sdl: 91.75 ms
sdl: 92.17 ms
sdl: 92.50 ms
sdl: 92.75 ms
sdl: 92.83 ms
sdl: 93.00 ms
sdl: 93.17 ms
sdl: 93.25 ms
sdl: 94.00 ms
sdl: 94.12 ms
sdl: 95.25 ms
sdl: 95.75 ms
sdl: 96.00 ms
sdl: 96.50 ms
sdl: 96.75 ms
sdl: 97.00 ms
sdl: 97.25 ms
sdl: 97.50 ms
sdl: 98.25 ms
sdl: 99.00 ms
sdl: 99.50 ms
```

---

### 网络问题分析

⚠ **检测到网络问题**

**重传统计：**
    3604 segments retransmitted
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

