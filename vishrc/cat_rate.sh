#!/bin/zsh

while read ss
do
    source=$(echo "$ss" | sed 's/"//g')
    target=$(echo "$ss" | sed "s/\/[6-9]\s\([^\/]*$\)/\/\1/g;s/\/\([^\/]*$\)/\/$2 \1/g;s/  \+/ /g;s/\"//g")
    mv -nv "$source" "$target"
done < "$1"
