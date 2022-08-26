#!/bin/zsh

FILE="$1"

if (ffprobe  -print_format json -show_format -show_streams "$FILE" 2>&1 | grep -q 'moov atom not found')
then
    echo "$FILE is corrupted"
else
    echo "$FILE is ok"
fi
