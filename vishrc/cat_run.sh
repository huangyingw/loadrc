#!/bin/zsh

while read ss
do
    ~/loadrc/vishrc/vrun.sh "$ss" &
done < "$1"
