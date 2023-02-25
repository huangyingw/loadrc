#!/bin/zsh

volume=$(osascript -e 'output volume of (get volume settings)')
osascript -e 'set volume 0'

while read ss
do
    ss=$(echo "$ss" | sed 's/"//g')
    echo "now playing"
    echo "$ss"
    ~/loadrc/vishrc/vlc.sh "$ss"
done < "$1"

osascript -e "set volume $volume"
