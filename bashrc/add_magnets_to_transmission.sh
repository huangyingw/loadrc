#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

# 硬编码的文件路径
FILE="magnet_links.txt"

# 检查文件是否存在
if [ ! -f "$FILE" ]; then
    echo "文件不存在: $FILE"
    exit 1
fi

# 读取文件中的每一行并添加到 Transmission
while IFS= read -r magnet_link; do
    echo "正在添加: $magnet_link"
    transmission-remote -a "$magnet_link"
done < "$FILE"

echo "所有 Magnet 链接已添加到 Transmission。"

cd -
