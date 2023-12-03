#!/bin/zsh

while read ss
do
    # 尝试使用awk来提取逗号分隔的文件大小和路径
    filesize_old=$(echo "$ss" | awk -F',' '{print $1}' | sed 's/"//g')
    filepath=$(echo "$ss" | awk -F',' '{print $2}' | sed 's/"//g')

    # 如果filepath为空，则整个字符串可能只是一个路径
    if [ -z "$filepath" ]; then
        filepath=$filesize_old
        filesize_old=""
    fi

    # 检查逗号前面是否有数字（即文件大小）
    if [[ "$filesize_old" =~ ^[0-9]+$ ]]; then
        # 只检查文件是否还存在
        if [ -e "$filepath" ]; then
            echo "$filesize_old,\"$filepath\""
        fi
    else
        # 使用du -k来获取文件或目录的大小（以KB为单位），忽略错误信息
        filesize_kb=$(du -k "$filepath" 2>/dev/null | awk '{print $1}')

        # 如果文件或目录存在（即du命令成功执行）
        if [ -n "$filesize_kb" ]; then
            # 将文件大小从KB转换为字节
            filesize=$((filesize_kb * 1024))

            # 输出重新计算的文件大小和用双引号包裹的文件名
            echo "$filesize,\"$filepath\""
        fi
    fi
done < "$1"
