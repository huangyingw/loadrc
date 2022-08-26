#!/bin/zsh

FILE="$1"

if (ffprobe  -print_format json -show_format -show_streams "$FILE" 2>&1 | grep -q 'moov atom not found')
then
    exit 1
fi
