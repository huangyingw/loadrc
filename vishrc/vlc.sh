#!/bin/zsh

if [ ! -d "$1" ]
then
    exit
fi

directory="$1"
line="$2"

# Use regex to match the timestamp at the end of the string
file_path=$(echo "$line" | sed -E 's/(:[0-9]{2}:[0-9]{2}(:[0-9]{2})?)$//')
timestamp=$(echo "$line" | sed -E 's/.*[^0-9:]([0-9]{1,2}:[0-9]{2}(:[0-9]{2})?)$/\1/')

echo "file_path --> $file_path"
echo "timestamp --> $timestamp"
