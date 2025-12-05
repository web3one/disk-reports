#!/bin/bash

# Ceph 性能分析脚本 - 分析监控数据并生成报告
# 用法: ./analyze_ceph_perf.sh <监控数据目录> <输出报告文件>

set -e

MONITOR_DIR="${1:-/tmp/ceph-monitoring}"
OUTPUT_REPORT="${2:-$MONITOR_DIR/ceph_analysis_report.md}"

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Ceph 性能分析${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""

# 检查监控数据目录
if [ ! -d "$MONITOR_DIR" ]; then
    echo -e "${RED}✗ 监控数据目录不存在: $MONITOR_DIR${NC}"
    exit 1
fi

echo -e "${GREEN}✓ 监控数据目录: $MONITOR_DIR${NC}"

# 分析函数
analyze_osd_perf() {
    local log_file="$MONITOR_DIR/ceph_osd_perf.log"
    if [ ! -f "$log_file" ]; then
        echo "OSD 性能日志不存在"
        return
    fi

    # 提取 apply latency 和 commit latency 的最大值
    local max_apply=$(grep -oP 'apply latency\s+:\s+\K[\d.]+' "$log_file" 2>/dev/null | sort -n | tail -1 || echo "0")
    local max_commit=$(grep -oP 'commit latency\s+:\s+\K[\d.]+' "$log_file" 2>/dev/null | sort -n | tail -1 || echo "0")
    local avg_apply=$(grep -oP 'apply latency\s+:\s+\K[\d.]+' "$log_file" 2>/dev/null | awk '{sum+=$1; count++} END {if(count>0) print sum/count; else print 0}')
    local avg_commit=$(grep -oP 'commit latency\s+:\s+\K[\d.]+' "$log_file" 2>/dev/null | awk '{sum+=$1; count++} END {if(count>0) print sum/count; else print 0}')

    echo "### OSD 延迟分析"
    echo ""
    echo "| 指标 | 平均值 (ms) | 峰值 (ms) | 状态 |"
    echo "|------|------------|----------|------|"

    # Apply Latency 分析
    local apply_status="✓ 正常"
    if (( $(echo "$max_apply > 100" | bc -l 2>/dev/null || echo 0) )); then
        apply_status="⚠ 峰值过高"
    fi
    printf "| OSD Apply Latency | %.2f | %.2f | %s |\n" "$avg_apply" "$max_apply" "$apply_status"

    # Commit Latency 分析
    local commit_status="✓ 正常"
    if (( $(echo "$max_commit > 100" | bc -l 2>/dev/null || echo 0) )); then
        commit_status="⚠ 峰值过高"
    fi
    printf "| OSD Commit Latency | %.2f | %.2f | %s |\n" "$avg_commit" "$max_commit" "$commit_status"
    echo ""
}

analyze_slow_ops() {
    local log_file="$MONITOR_DIR/slow_ops.log"
    if [ ! -f "$log_file" ]; then
        echo "慢操作日志不存在"
        return
    fi

    local slow_count=$(grep -c "检测到.*慢操作" "$log_file" 2>/dev/null)
    if [ -z "$slow_count" ]; then
        slow_count=0
    fi
    local max_slow=$(grep -oP "检测到 \K\d+" "$log_file" 2>/dev/null | sort -n | tail -1)
    if [ -z "$max_slow" ]; then
        max_slow=0
    fi

    echo "### 慢操作分析"
    echo ""
    echo "| 指标 | 值 | 状态 |"
    echo "|------|-------|------|"

    local status="✓ 正常"
    if [ "$slow_count" -gt 10 ]; then
        status="⚠ 频繁出现慢操作"
    elif [ "$slow_count" -gt 0 ]; then
        status="⚠ 偶现慢操作"
    fi

    echo "| 慢操作出现次数 | $slow_count | $status |"
    echo "| 单次最大慢操作数 | $max_slow | - |"
    echo ""

    if [ "$slow_count" -gt 0 ]; then
        echo "**慢操作样本（最后 5 条）：**"
        echo '```'
        grep "检测到.*慢操作" "$log_file" 2>/dev/null | tail -5 || echo "无详细信息"
        echo '```'
        echo ""
    fi
}

analyze_iostat() {
    local log_file="$MONITOR_DIR/iostat.log"
    if [ ! -f "$log_file" ]; then
        echo "iostat 日志不存在"
        return
    fi

    echo "### 磁盘 I/O 瓶颈分析"
    echo ""

    # 提取高利用率设备（util > 90%）
    local high_util_devices=$(awk '/^[a-z]/ && NF > 10 {if($NF > 90) print $1": "$NF"%"}' "$log_file" 2>/dev/null | sort -u || echo "")

    if [ -n "$high_util_devices" ]; then
        echo "**⚠ 检测到高利用率磁盘（util > 90%）：**"
        echo '```'
        echo "$high_util_devices"
        echo '```'
        echo ""
        echo "**建议**: 高利用率磁盘可能成为瓶颈，检查是否为慢盘或负载不均。"
    else
        echo "✓ 未检测到磁盘 I/O 瓶颈（util < 90%）"
    fi
    echo ""

    # 提取高延迟设备（await > 50ms）
    local high_latency=$(awk '/^[a-z]/ && NF > 10 {await=$(NF-2); if(await > 50) print $1": "await" ms"}' "$log_file" 2>/dev/null | sort -u || echo "")

    if [ -n "$high_latency" ]; then
        echo "**⚠ 检测到高延迟磁盘（await > 50ms）：**"
        echo '```'
        echo "$high_latency"
        echo '```'
        echo ""
    fi
}

analyze_network() {
    local log_file="$MONITOR_DIR/network_stats.log"
    if [ ! -f "$log_file" ]; then
        echo "网络统计日志不存在"
        return
    fi

    echo "### 网络问题分析"
    echo ""

    # 检测重传
    local retrans_count=$(grep -i "retransmit" "$log_file" 2>/dev/null | grep -oP '\d+' | head -1 || echo "0")
    local has_errors=$(grep -iE "error|drop" "$log_file" 2>/dev/null | head -5)

    if [ "$retrans_count" -gt 1000 ] || [ -n "$has_errors" ]; then
        echo "⚠ **检测到网络问题**"
        echo ""
        echo "**重传统计：**"
        grep -i "retransmit" "$log_file" 2>/dev/null | head -3 || echo "无数据"
        echo ""
        echo "**错误/丢包：**"
        echo '```'
        grep -iE "error|drop" "$log_file" 2>/dev/null | head -5 || echo "无数据"
        echo '```'
        echo ""
        echo "**建议**: 网络重传或丢包可能导致延迟抖动，检查交换机/网卡配置。"
    else
        echo "✓ 未检测到明显网络问题"
    fi
    echo ""
}

analyze_dmesg_errors() {
    local log_file="$MONITOR_DIR/dmesg_errors.log"
    if [ ! -f "$log_file" ]; then
        echo "dmesg 日志不存在"
        return
    fi

    echo "### 内核 I/O 错误分析"
    echo ""

    local error_count=$(grep -ciE "error|fail|timeout" "$log_file" 2>/dev/null || echo "0")

    if [ "$error_count" -gt 0 ]; then
        echo "⚠ **检测到 $error_count 条内核 I/O 相关错误**"
        echo ""
        echo "**最近错误样本（最后 10 条）：**"
        echo '```'
        grep -iE "error|fail|timeout" "$log_file" 2>/dev/null | tail -10 || echo "无详细信息"
        echo '```'
        echo ""
        echo "**建议**: 内核 I/O 错误可能表明硬件故障，检查磁盘 SMART 状态和系统日志。"
    else
        echo "✓ 未检测到内核 I/O 错误"
    fi
    echo ""
}

analyze_osd_df() {
    local log_file="$MONITOR_DIR/ceph_osd_df.log"
    if [ ! -f "$log_file" ]; then
        echo "OSD 磁盘使用日志不存在"
        return
    fi

    echo "### OSD 磁盘空间分析"
    echo ""

    # 提取使用率 > 80% 的 OSD
    local high_usage=$(grep -oP 'osd\.\d+.*\s+\d+\.\d+%' "$log_file" 2>/dev/null | awk '{if($NF+0 > 80) print}' | sort -u)

    if [ -n "$high_usage" ]; then
        echo "⚠ **检测到高磁盘使用率 OSD（> 80%）：**"
        echo '```'
        echo "$high_usage"
        echo '```'
        echo ""
        echo "**建议**: 高磁盘使用率可能触发 rebalance，影响性能。考虑扩容或清理数据。"
    else
        echo "✓ 所有 OSD 磁盘使用率正常（< 80%）"
    fi
    echo ""
}

# 生成报告
{
    echo "# Ceph 性能瓶颈分析报告"
    echo ""
    echo "**分析时间**: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "**监控数据目录**: $MONITOR_DIR"
    echo ""
    echo "---"
    echo ""

    analyze_osd_perf
    echo "---"
    echo ""

    analyze_slow_ops
    echo "---"
    echo ""

    analyze_iostat
    echo "---"
    echo ""

    analyze_network
    echo "---"
    echo ""

    analyze_dmesg_errors
    echo "---"
    echo ""

    analyze_osd_df
    echo "---"
    echo ""

    echo "## 瓶颈诊断总结"
    echo ""
    echo "### 常见瓶颈类型及处理建议"
    echo ""
    echo "1. **OSD 延迟过高**"
    echo "   - **现象**: Apply/Commit Latency > 100ms"
    echo "   - **可能原因**: 慢盘、磁盘故障、OSD 过载"
    echo "   - **处理建议**: 检查慢盘（smartctl）、平衡 OSD 负载、更换故障盘"
    echo ""
    echo "2. **频繁慢操作**"
    echo "   - **现象**: Slow ops 频繁出现"
    echo "   - **可能原因**: 网络延迟、OSD 繁忙、PG 不均衡"
    echo "   - **处理建议**: 检查网络、优化 CRUSH map、调整 PG 数量"
    echo ""
    echo "3. **磁盘 I/O 瓶颈**"
    echo "   - **现象**: 磁盘 util > 90%，await > 50ms"
    echo "   - **可能原因**: 单盘 IOPS/带宽达到上限"
    echo "   - **处理建议**: 负载均衡、增加缓存盘（NVMe metadata）、升级硬件"
    echo ""
    echo "4. **网络抖动**"
    echo "   - **现象**: 高重传率、丢包"
    echo "   - **可能原因**: 网络拥塞、交换机故障、MTU 不匹配"
    echo "   - **处理建议**: 检查交换机端口、启用 Jumbo Frame、优化 QoS"
    echo ""
    echo "5. **内核 I/O 错误**"
    echo "   - **现象**: dmesg 出现 I/O error/timeout"
    echo "   - **可能原因**: 硬件故障（磁盘、HBA、线缆）"
    echo "   - **处理建议**: 立即更换故障硬件，避免数据丢失"
    echo ""

} > "$OUTPUT_REPORT"

echo -e "${GREEN}✓ 分析报告已生成: $OUTPUT_REPORT${NC}"
echo ""
echo "查看报告: cat $OUTPUT_REPORT"

