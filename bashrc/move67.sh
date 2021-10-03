#!/bin/zsh
function move_zarchive()
{
    num=$1
    find /media/volgrp/mirror1/av/ -type f -size +100M -name $num\* | while read ss
    do 
        dir=$(echo "$ss" | sed 's/\/mirror1\//\/zarchive\//g'); mkdir -p "$(dirname "$dir")";mv -v "$ss" "$(dirname "$dir")"
    done
}

for (( c=6; c<=8; c++ ))
do
    echo "Welcome $c times"
    move_zarchive "$c"
done
