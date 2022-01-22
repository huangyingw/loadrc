#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

cd ~/imvu/website-project/website/
ps ax|awk '/\yfind\y/{print $1}' | while read ss; do kill -9 "$ss"; done
ps ax|awk '/\ycscope\y/{print $1}' | while read ss; do kill -9 "$ss"; done
time \
    find . -type f > /dev/null 2>&1

time \
    find . -type f -exec file {} + | grep text | cut -d: -f1 > /dev/null 2>&1

time \
    find . -type f -exec grep -Il "" {} + > /dev/null 2>&1
