#!/bin/zsh

while read ss
do
    ~/loadrc/bashrc/append_rate.sh "$ss"
done < "$1"
