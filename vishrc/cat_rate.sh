#!/bin/zsh

while read ss
do
    source=$(echo "$ss" | sed 's/"//g')
    target=$(~/loadrc/bashrc/append_num.sh "$ss")
    mv -nv "$source" "$target"
done < "$1"
