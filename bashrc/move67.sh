#!/bin/zsh

find /media/volgrp/mirror1/av/ -type f -size +100M  | while read ss
do
    target=$(echo "$ss" | sed 's/\/mirror1\(\/.*\/[6-8]\s\)/\/zarchive\1/g')

    if [ "$ss" != "$target" ]
    then
        echo mv -nv "$ss" "$target"
    fi
done
