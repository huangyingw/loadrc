#!/bin/zsh

source="/media/mapper/115_disk/av/av91/av"
target="/media/mapper/115_disk/av"
file="/media/mapper/115_disk/av/av91/av/zunsafe/旬果/ssis-506-4k/7 ssis-506-4k.mp4"

echo "file --> $file"
echo "target --> $target"
echo "file --> $file" | sed -e "s#$source#$target#g"
