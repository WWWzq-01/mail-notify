#!/bin/bash

# 使用默认的收件人邮箱地址，如果没有提供则使用该默认值
DEFAULT_EMAIL="wwwzq1222@163.com"


# 检查是否提供了邮箱地址，如果没有则使用默认值
EMAIL=${2:-$DEFAULT_EMAIL}

# 执行命令
eval "$1"

# 检查命令执行状态
if [ $? -eq 0 ]; then
    # 发送通知邮件
    echo "The command '$1' has completed successfully." | mail -s "Command Completion Notification" "$EMAIL"
else
    # 发送失败通知邮件
    echo "The command '$1' has failed." | mail -s "Command Failure Notification" "$EMAIL"
fi
