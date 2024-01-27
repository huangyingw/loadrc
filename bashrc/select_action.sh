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

# 定义一个数组来存储 rsync 的选项
RSYNC_OPTIONS=(-aHv --force --progress)

# 根据动作选择是否添加移除源文件的选项
if [ "$ACTION" = "move" ]; then
    RSYNC_OPTIONS+=("--remove-source-files")
fi

# 执行 rsync
rsync "${RSYNC_OPTIONS[@]}" --files-from="$FILE_LIST".tmp . "$DESTINATION"
