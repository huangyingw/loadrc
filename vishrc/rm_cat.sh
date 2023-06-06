#!/bin/zsh

while read ss
do
    ss=$(echo "$ss" | sed 's/"//g' | sed 's/^[0-9]*,//')
    rm "$ss"
done < "$1"
