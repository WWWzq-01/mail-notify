#!/bin/bash

# 使用默认的收件人邮箱地址，如果没有提供则使用该默认值
DEFAULT_EMAIL="wwwzq1222@163.com"

# 检查是否提供了邮箱地址，如果没有则使用默认值
EMAIL=${2:-$DEFAULT_EMAIL}

# 创建临时文件用于捕获输出和错误
OUTFILE=$(mktemp)
ERRFILE=$(mktemp)

# 执行命令并捕获输出和错误
eval "$1" >"$OUTFILE" 2>"$ERRFILE"
STATUS=$?

# 读取输出和错误内容
OUTPUT=$(cat "$OUTFILE")
ERROR=$(cat "$ERRFILE")

# 检查命令执行状态
if [ $STATUS -eq 0 ]; then
    # 发送成功通知邮件，并附上命令的输出
    echo -e "The command '$1' has completed successfully.\n\nOutput:\n$OUTPUT" | mail -s "Command Completion Notification" "$EMAIL"
else
    # 发送失败通知邮件，并附上命令的输出和错误
    echo -e "The command '$1' has failed.\n\nOutput:\n$OUTPUT\n\nError:\n$ERROR" | mail -s "Command Failure Notification" "$EMAIL"
fi

# 清理临时文件
rm "$OUTFILE" "$ERRFILE"