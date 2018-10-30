#!/bin/bash -
SCRIPT=$(realpath "$1")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

listFile="mylist.txt"
find . -type f | sed 's/\(["'\''\]\)/\\\1/g;s/.*/file '&'/' > "$listFile" && \
    nvim "$listFile" && \
    ffmpeg -f concat -safe 0 -i "$listFile" -c copy output.avi
