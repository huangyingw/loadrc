#!/bin/bash - 
targetFile="$1"
keyWord="$2"
sed -i.bak "/$keyWord/,$!d" $targetFile 
tail -qr $targetFile | sed "/$keyWord/,$!d" | tail -qr | tee $targetFile
