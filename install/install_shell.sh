#!/bin/bash

ln -s /usr/local/bin/notify.sh  $PWD/../notify.sh
echo "Symbolic link created successfully."
# 获取用户的默认 shell
user_shell=$(basename $SHELL)

# 根据 shell 类型确定配置文件
case "$user_shell" in
    bash)
        shell_config_file="$HOME/.bashrc"
        ;;
    zsh)
        shell_config_file="$HOME/.zshrc"
        ;;
    ksh)
        shell_config_file="$HOME/.kshrc"
        ;;
    fish)
        shell_config_file="$HOME/.config/fish/config.fish"
        ;;
    *)
        echo "Unsupported shell: $user_shell"
        exit 1
        ;;
esac

# 添加 alias 到配置文件中
echo "alias notify='/usr/local/bin/notify.sh'" >> $shell_config_file

# 重新加载配置文件
source $shell_config_file

echo "Alias added and configuration file reloaded successfully."