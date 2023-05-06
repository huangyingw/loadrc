#!/bin/zsh

line="./mapper/usb_backup_crypt_8T_1/115download/031215_043-1pon-1080p.mp4/9 uncensored 031215_043-1pon-1080p:02:17:17"

# Use regex to match the timestamp at the end of the string
file_path=$(echo "$line" | perl -pe 's/:[0-9]{1,2}:[0-9]{2}$//')
timestamp=$(echo "$line" | perl -pe 's/.*:([0-9]{1,2}:[0-9]{2})$/\1/')

echo "file_path --> $file_path"
echo "timestamp --> $timestamp"
