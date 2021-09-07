#!/bin/zsh

# https://stackoverflow.com/questions/1616577/surround-all-lines-in-a-text-file-with-quotes-something
listFile="mylist.txt"
if [ -f "$listFile" ]
then
    ffmpeg -f concat -safe 0 -i "$listFile" -c copy -y output.avi
    rm "$listFile"
else
    find . -type f | sed -e "s/'/'\\\\''/g;s/\(.*\)/file '\1'/" > "$listFile"
fi
