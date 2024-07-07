#!/bin/bash

# 使用默认的收件人邮箱地址，如果没有提供则使用该默认值
DEFAULT_EMAIL="wwwzq1222@163.com"


# 检查是否提供了邮箱地址，如果没有则使用默认值
EMAIL=${2:-$DEFAULT_EMAIL}

# 执行命令并捕获输出和错误
OUTPUT=$(eval "$1" 2>&1)
STATUS=$?

# 检查命令执行状态
if [ $STATUS -eq 0 ]; then
    # 发送成功通知邮件，并附上命令的输出
    echo -e "The command '$1' has completed successfully.\n\nOutput:\n$OUTPUT" | mail -s "Command Completion Notification" "$EMAIL"
else
    # 发送失败通知邮件，并附上命令的输出和错误
    echo -e "The command '$1' has failed.\n\nOutput:\n$OUTPUT" | mail -s "Command Failure Notification" "$EMAIL"
fi