#!/bin/zsh

while read ss
do
    ~/loadrc/bashrc/append_cat.sh "$ss"
done < "$1"
