#!/bin/bash -
SCRIPT=$(realpath "$1")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

# https://stackoverflow.com/questions/1616577/surround-all-lines-in-a-text-file-with-quotes-something
listFile="mylist.txt"
find . -type f | sed -e "s/'/'\\\\''/g;s/\(.*\)/file '\1'/" > "$listFile" && \
    nvim "$listFile" && \
    ffmpeg -f concat -safe 0 -i "$listFile" -c copy output.avi
