#!/bin/zsh

while read ss
do
    ss=$(echo "$ss" | sed 's/"//g')
    echo "now playing $ss"
    smplayer -fullscreen "$ss"
done < "$1"
