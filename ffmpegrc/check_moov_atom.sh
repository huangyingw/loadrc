#!/bin/zsh

FILE="$1"
ffprobe  -print_format json -show_format -show_streams "$FILE"
