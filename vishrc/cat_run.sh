#!/bin/zsh

while read ss
do
    ss=$(echo "$ss" | sed 's/"//g;s/\.\///g')
    ~/loadrc/vishrc/vrun.sh "$ss" &
done < "$1"
