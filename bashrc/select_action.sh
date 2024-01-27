#!/bin/zsh

# 检查参数数量
if [ "$#" -lt 3 ]; then
    echo "Usage: $0 <file list> <destination> <action>"
    exit 1
fi

# 参数解析
FILE_LIST="$1"
DESTINATION="$2"
ACTION="$3"

# 处理文件列表，移除引号和转义空格
cat "$FILE_LIST" | sed 's/^"//g;s/"$//g;s/\\ / /g' > "$FILE_LIST".tmp

# 根据动作选择 rsync 选项
case "$ACTION" in
    copy)
        RSYNC_OPTIONS="-aHv --force --progress"
        ;;
    move)
        RSYNC_OPTIONS="-aHv --force --progress --remove-source-files"
        ;;
    *)
        echo "Invalid action: $ACTION"
        exit 1
        ;;
esac

# 执行 rsync
rsync $RSYNC_OPTIONS --files-from "$FILE_LIST".tmp . "$DESTINATION"
