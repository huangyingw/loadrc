#! /bin/zsh

FAV=/media/volgrp/mirror1/av/

if [ -d "$FAV" ]
then
    cd "$FAV"

    find . -type f -size +100M -exec ls -S {} \+ > fav.log
    find . -type f -size +10M -exec ls -t {} \+ > fav.log.sort
    touch files.proj
fi

FAV=/home/parallels/server/media/volgrp/mirror1/av/

if [ -d "$FAV" ]
then
    rm ~/fav/*
    find "$FAV" -type f -iname 9\* -size +300M -exec ls -rt {} \+ | while read ss
do
    ftemp=`basename "$ss"`
    ln -s "$ss" ~/fav/"$ftemp"
done
fi
