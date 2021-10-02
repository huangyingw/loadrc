#!/bin/zsh

while read ss
do
    target=$(echo "$ss" | sed "s/\/[6-9]\s\([^\/]*$\)/\/\1/g;s/\/\([^\/]*$\)/\/$2 \1/g;s/  \+/ /g")
    mv -nv "$ss" "$target"
done < "$1"
