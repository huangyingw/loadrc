#! /bin/bash

FAV=/media/volgrp/mirror/av/

if [ -d "$FAV" ]
then
    cd "$FAV"

    find . -type f -size +100M -exec ls -t {} \+ > files.proj
    touch files.proj
fi

FAV=/home/parallels/server/media/volgrp/mirror/av/

if [ -d "$FAV" ]
then
    rm ~/fav/*
    find "$FAV" -type f -iname 9\* -size +300M -exec ls -rt {} \+ | while read ss
do
    ftemp=`basename "$ss"`
    ln -s "$ss" ~/fav/"$ftemp"
done
fi
