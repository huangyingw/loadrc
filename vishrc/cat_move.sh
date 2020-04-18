#!/bin/zsh

while read ss
do
    ss=$(echo "$ss" | sed 's/"//g')
    mv -v "$ss" "$2"
done < "$1"
