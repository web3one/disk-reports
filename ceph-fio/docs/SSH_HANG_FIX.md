# SSH 执行挂起问题修复说明

## 问题描述

执行 `run_disks_report.sh` 时，SSH 命令执行后脚本不再向下继续执行，停在了：

```bash
ssh -n "${REMOTE_USER}@${REMOTE_HOST}" "${SSH_CMD} < /dev/null"
```

## 问题根源

SSH 会话会等待以下条件都满足后才退出：
1. 远程命令主进程退出
2. 所有后台进程退出
3. 所有与 SSH 会话关联的文件描述符（stdin/stdout/stderr）关闭

在我们的场景中，存在以下问题：

### 1. `ceph_perf_monitor.sh` 使用了阻塞式 `wait`
```bash
done &
wait  # ← 这会永久等待后台进程
```

这导致监控脚本永远不会主动退出。

### 2. 后台进程的文件描述符未分离
在 `local_fio.sh` 中启动监控脚本时：
```bash
"$CEPH_MONITOR_SCRIPT" "$CEPH_MONITOR_DIR" 5 &
```

后台进程的 stdin/stdout/stderr 仍然连接到父进程，进而关联到 SSH 会话。

### 3. 子进程（iostat）可能继续运行
监控脚本启动的 `iostat` 子进程在父进程被 kill 后可能仍然运行。

## 修复方案

### 修复 1：完全分离后台监控进程（`local_fio.sh`）

**修改前：**
```bash
"$CEPH_MONITOR_SCRIPT" "$CEPH_MONITOR_DIR" 5 &
CEPH_MONITOR_PID=$!
```

**修改后：**
```bash
nohup "$CEPH_MONITOR_SCRIPT" "$CEPH_MONITOR_DIR" 5 > /dev/null 2>&1 </dev/null &
CEPH_MONITOR_PID=$!
```

**说明：**
- `nohup` - 防止进程接收 SIGHUP 信号
- `> /dev/null 2>&1` - 重定向 stdout 和 stderr 到 /dev/null
- `</dev/null` - 重定向 stdin 从 /dev/null 读取
- 这样后台进程完全从 SSH 会话中分离

### 修复 2：改进监控进程停止逻辑（`local_fio.sh`）

**修改前：**
```bash
kill -TERM "$CEPH_MONITOR_PID" 2>/dev/null || true
wait "$CEPH_MONITOR_PID" 2>/dev/null || true
pkill -P "$CEPH_MONITOR_PID" 2>/dev/null || true
```

**修改后：**
```bash
# 先停止子进程（如 iostat）
pkill -P "$CEPH_MONITOR_PID" 2>/dev/null || true
# 再停止主监控进程
kill -TERM "$CEPH_MONITOR_PID" 2>/dev/null || true
# 等待最多 3 秒
for i in {1..3}; do
    if ! kill -0 "$CEPH_MONITOR_PID" 2>/dev/null; then
        break
    fi
    sleep 1
done
# 如果还没退出，强制杀死
if kill -0 "$CEPH_MONITOR_PID" 2>/dev/null; then
    kill -9 "$CEPH_MONITOR_PID" 2>/dev/null || true
fi
```

**说明：**
- 先杀子进程，再杀父进程
- 给进程 3 秒优雅退出时间
- 如果仍未退出，使用 SIGKILL 强制杀死
- 移除了可能阻塞的 `wait` 命令

### 修复 3：修正监控脚本的 wait 命令（`ceph_perf_monitor.sh`）

**修改前：**
```bash
done &
# 保持脚本运行（后台循环已启动）
wait
```

**修改后：**
```bash
done &
# 保存后台循环的 PID
MONITOR_LOOP_PID=$!
echo "$MONITOR_LOOP_PID" > "$OUTPUT_DIR/monitor_loop.pid"

# 等待后台监控循环（会被 SIGTERM 信号中断）
wait "$MONITOR_LOOP_PID" 2>/dev/null || true

# 清理 iostat 进程
if [ -n "$IOSTAT_PID" ] && kill -0 "$IOSTAT_PID" 2>/dev/null; then
    kill -TERM "$IOSTAT_PID" 2>/dev/null || true
fi

echo "监控脚本已退出: $(date '+%Y-%m-%d %H:%M:%S')" | tee -a "$CEPH_STATUS_LOG"
```

**说明：**
- 等待特定的后台循环 PID，而不是等待所有后台进程
- 收到 SIGTERM 信号时会中断 wait 并继续执行
- 主动清理 iostat 子进程
- 记录退出日志

## 验证方法

执行脚本后，应该能看到完整的输出流程：

```bash
→ 上传脚本到 ubuntu@dc1-stor40:/home/ubuntu/local_fio.sh
→ 远端执行 FIO 脚本
[远程脚本输出...]
→ 同步远端报告目录到本地并覆盖
✓ 完成
```

如果仍然挂起，可以：

1. **检查远程进程：**
```bash
ssh ubuntu@dc1-stor40 "ps aux | grep -E 'fio|monitor|iostat'"
```

2. **手动清理：**
```bash
ssh ubuntu@dc1-stor40 "pkill -f ceph_perf_monitor.sh; pkill iostat"
```

3. **检查 SSH 连接状态：**
```bash
ssh -vvv ubuntu@dc1-stor40 "echo test"  # 查看详细连接日志
```

## 最佳实践总结

1. **后台进程分离三要素：**
   - 使用 `nohup` 防止 SIGHUP
   - 重定向所有文件描述符（stdin, stdout, stderr）
   - 使用 `&` 放到后台

2. **SSH 远程执行注意事项：**
   - 使用 `-n` 选项防止 SSH 读取 stdin
   - 确保远程脚本中的所有后台进程都正确分离
   - 避免在远程脚本中使用无参数的 `wait`

3. **进程清理顺序：**
   - 先清理子进程（使用 `pkill -P`）
   - 再清理父进程（使用 `kill`）
   - 给进程优雅退出的时间
   - 必要时使用 `SIGKILL` 强制杀死

## 相关技术文档

- [SSH man page - -n option](https://man.openbsd.org/ssh)
- [Bash wait command](https://www.gnu.org/software/bash/manual/html_node/Job-Control-Builtins.html)
- [Process file descriptors](https://tldp.org/LDP/abs/html/io-redirection.html)

