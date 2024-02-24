#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

# 直接指定ED2K链接文件的路径
FILE="ed2k_links.txt"

# 检查文件是否存在
if [ ! -f "$FILE" ]; then
    echo "文件不存在: $FILE"
    exit 1
fi

# 读取文件中的每一行
while IFS= read -r line; do
    # 使用amulecmd添加ED2K链接
    echo -e "Add $line\nexit" | amulecmd -P amulecmd
done < "$FILE"

echo "所有链接已添加到aMule。"
