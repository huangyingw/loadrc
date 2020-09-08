#!/bin/zsh
if [ ! -d "$2" ]
then
    mkdir -p "$2"
fi

while read ss
do
    ss=$(echo "$ss" | sed 's/"//g')
    mv -nv "$ss" "$2"
done < "$1"
