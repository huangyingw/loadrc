#!/bin/zsh

while read ss
do
    ss=$(echo "$ss" | sed 's/"//g')
    rm "$ss"
done < "$1"
