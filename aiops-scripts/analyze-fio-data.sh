#!/bin/bash
# FIO 测试数据写入量分析脚本
# 用于分析为什么 FIO 压测 50GB，但 Ceph 统计显示为 25GB

set -euo pipefail

echo "=== FIO 测试数据写入量分析 ==="
echo ""

# 配置
POOL_NAME="${1:-ceph-blockpool}"
IMAGE_NAME="${2:-test-volume-hdd-1764584770}"
FIO_CONFIG="${3:-config/test-prepare.fio}"

echo "1. FIO 配置分析"
echo "----------------------------------------"
if [ -f "$FIO_CONFIG" ]; then
    echo "配置文件: $FIO_CONFIG"
    echo ""

    # 提取关键配置
    echo "关键配置参数:"
    grep -E "^size=" "$FIO_CONFIG" || echo "  未找到 size 配置"
    grep -E "^bs=" "$FIO_CONFIG" || echo "  未找到 bs 配置"
    grep -E "^rw=" "$FIO_CONFIG" || echo "  未找到 rw 配置"
    grep -E "^numjobs=" "$FIO_CONFIG" || echo "  未找到 numjobs 配置"
    grep -E "^iodepth=" "$FIO_CONFIG" || echo "  未找到 iodepth 配置"
    grep -E "^time_based=" "$FIO_CONFIG" || echo "  未找到 time_based 配置"
    grep -E "^runtime=" "$FIO_CONFIG" || echo "  未找到 runtime 配置"
    echo ""

    # 分析写入模式
    echo "FIO 任务列表:"
    grep -E "^\[.*\]" "$FIO_CONFIG" | grep -v "^\[global\]" || echo "  未找到任务定义"
    echo ""
else
    echo "⚠️ 配置文件不存在: $FIO_CONFIG"
    echo ""
fi

echo "2. RBD 镜像信息"
echo "----------------------------------------"
if command -v rbd &> /dev/null; then
    echo "RBD 镜像: $POOL_NAME/$IMAGE_NAME"

    # 镜像基本信息
    echo ""
    echo "镜像详细信息:"
    rbd info "$POOL_NAME/$IMAGE_NAME" 2>/dev/null || echo "  ✗ 无法获取镜像信息"

    # 磁盘使用情况
    echo ""
    echo "磁盘使用统计:"
    rbd du "$POOL_NAME/$IMAGE_NAME" 2>/dev/null || echo "  ✗ 无法获取使用统计"

    # 检查 RBD features
    echo ""
    echo "RBD 特性:"
    rbd info "$POOL_NAME/$IMAGE_NAME" 2>/dev/null | grep -i "features:" || echo "  未找到特性信息"

else
    echo "⚠️ rbd 命令不可用"
fi
echo ""

echo "3. 存储池配置"
echo "----------------------------------------"
if command -v ceph &> /dev/null; then
    echo "存储池: $POOL_NAME"
    echo ""

    # 副本数
    echo "副本配置:"
    ceph osd pool get "$POOL_NAME" size 2>/dev/null | awk '{print "  副本数 (size): " $2}' || echo "  ✗ 无法获取副本数"
    ceph osd pool get "$POOL_NAME" min_size 2>/dev/null | awk '{print "  最小副本数 (min_size): " $2}' || echo "  ✗ 无法获取最小副本数"

    # 压缩配置
    echo ""
    echo "压缩配置:"
    ceph osd pool get "$POOL_NAME" compression_mode 2>/dev/null | awk '{print "  压缩模式: " $2}' || echo "  ✗ 无法获取压缩配置"

    # 存储池统计
    echo ""
    echo "存储池使用情况:"
    ceph df | grep -A 1 "^POOL" | grep "$POOL_NAME" || echo "  ✗ 无法获取存储池统计"

else
    echo "⚠️ ceph 命令不可用"
fi
echo ""

echo "4. 数据写入量计算分析"
echo "----------------------------------------"
echo "理论计算公式:"
echo "  实际写入量 = FIO size × numjobs × 任务数"
echo "  (如果 time_based=1，则受 runtime 限制)"
echo ""

# 尝试从 FIO 配置中提取数值进行计算
if [ -f "$FIO_CONFIG" ]; then
    SIZE=$(grep -E "^size=" "$FIO_CONFIG" | head -1 | cut -d'=' -f2)
    NUMJOBS=$(grep -E "^numjobs=" "$FIO_CONFIG" | head -1 | cut -d'=' -f2)
    TIME_BASED=$(grep -E "^time_based=" "$FIO_CONFIG" | head -1 | cut -d'=' -f2)
    RUNTIME=$(grep -E "^runtime=" "$FIO_CONFIG" | head -1 | cut -d'=' -f2)

    echo "从配置文件提取的参数:"
    [ -n "$SIZE" ] && echo "  size: $SIZE"
    [ -n "$NUMJOBS" ] && echo "  numjobs: $NUMJOBS"
    [ -n "$TIME_BASED" ] && echo "  time_based: $TIME_BASED"
    [ -n "$RUNTIME" ] && echo "  runtime: $RUNTIME"
    echo ""

    if [ "$TIME_BASED" = "1" ] && [ -n "$RUNTIME" ]; then
        echo "⚠️ 注意: time_based=1，实际写入量受 runtime=$RUNTIME 秒限制"
        echo "         写入量 = 写入速度 × runtime，而不是 size 参数"
        echo ""
    fi
fi

echo "5. 可能的原因分析"
echo "----------------------------------------"
echo "如果 FIO 压测 50GB，但 Ceph 统计显示 25GB，可能的原因："
echo ""
echo "原因 1: RBD Sparse（稀疏）特性"
echo "  • RBD 默认启用稀疏镜像特性"
echo "  • 'rbd du' 只统计实际写入的数据块"
echo "  • 如果 FIO 只写入了部分数据块，统计会少于预期"
echo ""
echo "原因 2: FIO time_based 模式"
echo "  • time_based=1 时，FIO 按时间运行而非数据量"
echo "  • 实际写入量 = 写入速度 × runtime"
echo "  • 如果写入速度较慢，可能达不到 50GB"
echo ""
echo "原因 3: FIO 测试阶段"
echo "  • 如果配置文件包含多个测试阶段（stonewall）"
echo "  • PREPARE 阶段可能只写入部分数据"
echo "  • 后续的读写测试不会增加数据量"
echo ""
echo "原因 4: 副本数统计"
echo "  • Ceph 默认显示逻辑数据量（除以副本数）"
echo "  • 物理占用 = 逻辑数据 × 副本数"
echo "  • 如果配置 3 副本，物理占用应为 25GB × 3 = 75GB"
echo ""

echo "6. 验证建议"
echo "----------------------------------------"
echo "1. 检查 FIO 输出日志，确认实际写入的数据量"
echo "2. 查看 'ceph df' 的 USED 列（物理占用）而非 STORED 列"
echo "3. 使用 'rados df' 查看存储池的详细统计"
echo "4. 检查 RBD 镜像的 'rbd diff' 确认实际写入的数据块"
echo "5. 如果需要准确写入 50GB，使用 time_based=0 模式"
echo ""

echo "=== 分析完成 ==="

