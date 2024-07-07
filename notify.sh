#!/bin/bash

# 使用默认的收件人邮箱地址，如果没有提供则使用该默认值
DEFAULT_EMAIL="wwwzq1222@163.com"

# 检查是否提供了邮箱地址，如果没有则使用默认值
EMAIL=${2:-$DEFAULT_EMAIL}

# 创建临时文件用于捕获输出和错误
OUTFILE=$(mktemp)
ERRFILE=$(mktemp)

# 记录开始时间
START_TIME=$(date +%s)
START_TIME_READABLE=$(date)

# 执行命令并分别捕获输出和错误，同时输出到终端
{
  eval "$1" 2> >(tee "$ERRFILE" >&2)
} | tee "$OUTFILE"
STATUS=${PIPESTATUS[0]}

# 记录结束时间
END_TIME=$(date +%s)
END_TIME_READABLE=$(date)
EXECUTION_TIME=$((END_TIME - START_TIME))

# 读取输出和错误内容
OUTPUT=$(cat "$OUTFILE")
ERROR=$(cat "$ERRFILE")

# 创建邮件内容的临时文件
MAIL_CONTENT=$(mktemp)
if [ $STATUS -eq 0 ]; then
    # 成功通知邮件内容
    printf "The command '%s' has completed successfully.\n\nStart Time: %s\nEnd Time: %s\nExecution Time: %ds\n\nOutput:\n %s \n" "$1" "$START_TIME_READABLE" "$END_TIME_READABLE" "$EXECUTION_TIME" "$OUTPUT" > "$MAIL_CONTENT"
else
    # 失败通知邮件内容
    printf "The command '%s' has failed.\n\nStart Time: %s\nEnd Time: %s\nExecution Time: %ds\n\nOutput:\n %s \n\nError:\n %s \n" "$1" "$START_TIME_READABLE" "$END_TIME_READABLE" "$EXECUTION_TIME" "$OUTPUT" "$ERROR" > "$MAIL_CONTENT"
fi

# 发送邮件
cat "$MAIL_CONTENT" | mail -s "Command Notification" "$EMAIL"

# 清理临时文件
rm "$OUTFILE" "$ERRFILE" "$MAIL_CONTENT"
