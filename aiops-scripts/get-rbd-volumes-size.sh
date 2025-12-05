#!/bin/bash
# 计算 Ceph 存储池中每个 RBD 卷的大小
# 使用方法: ./get-rbd-volumes-size.sh

set -euo pipefail

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 存储池列表
POOLS=("ceph-blockpool" "ceph-nvme-blockpool")

echo "=========================================="
echo "  Ceph RBD 卷大小统计"
echo "=========================================="
echo ""

# 格式化字节大小为人类可读格式
format_bytes() {
    local bytes=$1
    if [ "$bytes" -lt 1024 ]; then
        echo "${bytes}B"
    elif [ "$bytes" -lt 1048576 ]; then
        echo "$(awk "BEGIN {printf \"%.2f\", $bytes/1024}")KB"
    elif [ "$bytes" -lt 1073741824 ]; then
        echo "$(awk "BEGIN {printf \"%.2f\", $bytes/1048576}")MB"
    elif [ "$bytes" -lt 1099511627776 ]; then
        echo "$(awk "BEGIN {printf \"%.2f\", $bytes/1073741824}")GB"
    else
        echo "$(awk "BEGIN {printf \"%.2f\", $bytes/1099511627776}")TB"
    fi
}

# 遍历每个存储池
for pool in "${POOLS[@]}"; do
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}存储池: ${YELLOW}$pool${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

    # 检查存储池是否存在
    if ! ceph osd pool ls | grep -q "^${pool}$"; then
        echo -e "${RED}✗ 存储池 $pool 不存在${NC}"
        echo ""
        continue
    fi

    # 获取存储池中的所有 RBD 镜像
    images=$(rbd ls "$pool" 2>/dev/null || true)

    if [ -z "$images" ]; then
        echo -e "${YELLOW}  (空) 该存储池中没有 RBD 卷${NC}"
        echo ""
        continue
    fi

    # 统计变量
    total_size_bytes=0
    total_used_bytes=0
    image_count=0

    echo ""
    printf "  %-40s %15s %15s %10s\n" "卷名称" "配置大小" "实际使用" "使用率"
    echo "  ────────────────────────────────────────────────────────────────────────────"

    # 遍历每个镜像
    while IFS= read -r image; do
        if [ -z "$image" ]; then
            continue
        fi

        image_count=$((image_count + 1))

        # 获取镜像详细信息
        info=$(rbd info "$pool/$image" 2>/dev/null || echo "")

        if [ -z "$info" ]; then
            echo -e "  ${RED}✗ 无法获取 $image 的信息${NC}"
            continue
        fi

        # 提取大小（字节）
        size_bytes=$(echo "$info" | grep "size" | head -1 | awk '{print $2}')

        # 提取单位并转换为字节
        size_unit=$(echo "$info" | grep "size" | head -1 | awk '{print $3}')
        case "$size_unit" in
            KiB) size_bytes=$((size_bytes * 1024)) ;;
            MiB) size_bytes=$((size_bytes * 1048576)) ;;
            GiB) size_bytes=$((size_bytes * 1073741824)) ;;
            TiB) size_bytes=$((size_bytes * 1099511627776)) ;;
        esac

        # 获取实际使用量（通过 disk_usage）
        du_output=$(rbd du "$pool/$image" 2>/dev/null || echo "")

        if [ -n "$du_output" ]; then
            # 提取 USED 列（实际使用）
            used_line=$(echo "$du_output" | grep "$image" | tail -1)
            used_size=$(echo "$used_line" | awk '{print $(NF-1)}')
            used_unit=$(echo "$used_line" | awk '{print $NF}')

            # 转换使用量为字节
            case "$used_unit" in
                B) used_bytes=$used_size ;;
                KiB) used_bytes=$(awk "BEGIN {printf \"%.0f\", $used_size * 1024}") ;;
                MiB) used_bytes=$(awk "BEGIN {printf \"%.0f\", $used_size * 1048576}") ;;
                GiB) used_bytes=$(awk "BEGIN {printf \"%.0f\", $used_size * 1073741824}") ;;
                TiB) used_bytes=$(awk "BEGIN {printf \"%.0f\", $used_size * 1099511627776}") ;;
                *) used_bytes=0 ;;
            esac
        else
            used_bytes=0
        fi

        # 计算使用率
        if [ "$size_bytes" -gt 0 ]; then
            usage_percent=$(awk "BEGIN {printf \"%.1f\", ($used_bytes / $size_bytes) * 100}")
        else
            usage_percent="0.0"
        fi

        # 格式化大小
        size_human=$(format_bytes "$size_bytes")
        used_human=$(format_bytes "$used_bytes")

        # 输出
        printf "  %-40s %15s %15s %9s%%\n" "$image" "$size_human" "$used_human" "$usage_percent"

        # 累加总量
        total_size_bytes=$((total_size_bytes + size_bytes))
        total_used_bytes=$((total_used_bytes + used_bytes))

    done <<< "$images"

    echo "  ────────────────────────────────────────────────────────────────────────────"

    # 计算总使用率
    if [ "$total_size_bytes" -gt 0 ]; then
        total_usage_percent=$(awk "BEGIN {printf \"%.1f\", ($total_used_bytes / $total_size_bytes) * 100}")
    else
        total_usage_percent="0.0"
    fi

    total_size_human=$(format_bytes "$total_size_bytes")
    total_used_human=$(format_bytes "$total_used_bytes")

    echo -e "  ${GREEN}总计 ($image_count 个卷):${NC}"
    printf "  %-40s %15s %15s %9s%%\n" "" "$total_size_human" "$total_used_human" "$total_usage_percent"
    echo ""

done

echo -e "${CYAN}=========================================="
echo -e "  统计完成"
echo -e "==========================================${NC}"

