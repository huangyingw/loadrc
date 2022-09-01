#!/bin/zsh

FILE="$1"
FILE=$(echo "$FILE" | sed 's/"//g')

if (ffprobe  -print_format json -show_format -show_streams "$FILE" 2>&1 | grep -q 'moov atom not found')
then
    exit 1
fi
