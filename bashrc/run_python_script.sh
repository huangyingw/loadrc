#!/bin/bash

# 检查文件是否存在
if [ ! -f "$1" ]; then
    echo "文件不存在: $1"
    exit 1
fi

file=$1

# 读取文件的第一行
first_line=$(head -n 1 "$file")

# 检查是否包含shebang
if [[ $first_line == \#!/* ]]; then
    chmod +x "$file"
    "$file"
else
    python "$file"
fi
