#!/bin/zsh

find /media/volgrp/mirror1/av/ -type f -size +100M  | while read ss
do
    target=$(echo "$ss" | sed 's/\/mirror1\(\/.*\/[6-8][^0-9][^\/]*$\)/\/zarchive\1/g')

    if [ "$ss" != "$target" ]
    then
        dir=$(dirname "$target")
        mkdir -p "$dir"
        source=$(echo "$ss" | sed 's/"//g')
        mv -nv "$source" "$target"
    fi
done
