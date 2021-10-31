#!/bin/zsh

while read ss
do
    ~/loadrc/bashrc/append_rate.sh "$ss" "$2"
done < "$1"
