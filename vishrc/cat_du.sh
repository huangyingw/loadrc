#!/bin/zsh

while read ss
do
    ss=$(echo "$ss" | sed 's/"//g')
    du -sh "$ss"
done < "$1"
