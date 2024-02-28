#!/bin/zsh

# 检查是否提供了TARGET参数
if [ -z "$1" ]
then
    echo -e "${red}Please provide TARGET ... ${NC}"
    exit 1
fi

TARGET="$1"

# 检查是否提供了文件大小的参数，如果没有提供，默认为500
FILESIZE=${2:-500}

# 将文件大小单位设置为MB
FILESIZE_MB="${FILESIZE}m"

# 获取当前日期和时间
dt=$(date '+%m_%d_%Y_%H_%M_%S')
logFile="$TARGET/jdupes.$dt.log"

# 打印出将要使用的参数
echo "Running jdupes with the following parameters:"
echo "TARGET: $TARGET"
echo "File Size Limit: $FILESIZE_MB"
echo "Log File: $logFile"

# 执行jdupes命令
jdupes -dNrO --order=time -X size+:"$FILESIZE_MB" -X nostr:/.git/ "$TARGET" 2>&1 | tee "$logFile"
