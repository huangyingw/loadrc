#!/bin/zsh


while read ss
do
    ss=$(echo "$ss" | sed 's/"//g')
    echo "now playing"
    echo "$ss"
    ~/loadrc/pythonrc/vlc.py "$1" "$ss"
done < "$1"
