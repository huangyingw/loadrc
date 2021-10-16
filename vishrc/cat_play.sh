#!/bin/zsh

while read ss
do
    ss=$(echo "$ss" | sed 's/"//g')
    echo "now playing"
    echo "$ss"
    ~/loadrc/vishrc/vlc.sh "$ss"
done < "$1"
