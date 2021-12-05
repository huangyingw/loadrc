#!/bin/zsh

if [ ! -d "$2" ]
then
    mkdir -p "$2"
fi

ss=$(echo "$1" | sed 's/"//g')
mv -nv "$ss" "$2"
