#!/bin/bash
set -euo pipefail

START_TIME=$(date +%s)

TEST_FILE="${1-/dev/rbd0}"
FIO_FILE="${2-test.fio}"
REPROT_NAME="${3-intel-4610-hdd}"


START_TIME=$(date +%s)
REMOTE_HOST="dc1-stor40"
REMOTE_USER="ubuntu"
REMOTE_SCRIPT="/home/ubuntu/local_fio.sh"
REMOTE_REPORT_DIR="/home/ubuntu/${REPROT_NAME}"
LOCAL_REPORT_DIR="../../../disks-report/${REPROT_NAME}"

echo "→ 上传脚本到 ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_SCRIPT}"
scp local_fio.sh "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_SCRIPT}"
scp ./config/${FIO_FILE} "${REMOTE_USER}@${REMOTE_HOST}:/home/ubuntu/${FIO_FILE}"
scp ceph_perf_monitor.sh "${REMOTE_USER}@${REMOTE_HOST}:/home/ubuntu/ceph_perf_monitor.sh"
scp analyze_ceph_perf.sh "${REMOTE_USER}@${REMOTE_HOST}:/home/ubuntu/analyze_ceph_perf.sh"

# 给所有脚本添加执行权限
SSH_CHMOD="chmod +x /home/ubuntu/local_fio.sh /home/ubuntu/ceph_perf_monitor.sh /home/ubuntu/analyze_ceph_perf.sh"
ssh "${REMOTE_USER}@${REMOTE_HOST}" "${SSH_CHMOD}"

SSH_CMD="sudo '${REMOTE_SCRIPT}' $(printf '%q' "${TEST_FILE}") $(printf '%q' "${FIO_FILE}") $(printf '%q' "${REMOTE_REPORT_DIR}")"

echo "→ 远端执行 FIO 脚本 "
echo "$(date -d "@${START_TIME}" +"%Y-%m-%d %H:%M:%S")"

if ! ssh "${REMOTE_USER}@${REMOTE_HOST}" "${SSH_CMD}"; then
    echo "⚠️ 远端 FIO 脚本执行返回错误，尝试同步日志..."
    SSH_EXIT_CODE=1
else
    SSH_EXIT_CODE=0
fi

echo "→ 同步远端报告目录到本地并覆盖"
rsync -avz --delete "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_REPORT_DIR}/" "${LOCAL_REPORT_DIR}/"

if [ "$SSH_EXIT_CODE" -ne 0 ]; then
    echo "✗ 任务失败，请检查本地同步的日志。"
    exit "$SSH_EXIT_CODE"
fi

END_TIME=$(date +%s)
ELAPSED_TIME=$((END_TIME - START_TIME))
MINUTES=$((ELAPSED_TIME / 60))
SECONDS=$((ELAPSED_TIME % 60))

echo "✓ 完成"
echo "⏱️  总执行时间: ${MINUTES} 分 ${SECONDS} 秒 (${ELAPSED_TIME} 秒)"
