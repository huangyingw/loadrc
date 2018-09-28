#! /bin/bash
if [ -z "$1" ]
then
    FAV=/home/parallels/movie/media/volgrp/av/
else
    FAV=`realpath "$1"`
fi

rm ~/fav/*
find "$FAV" -type f -mtime -700 -iname 9\* -size +600M -exec ls -rt {} \+|tail -n 100|while read ss
do
    ftemp=`basename "$ss"`
    ln -s "$ss" ~/fav/"$ftemp"
done

FAV=~/var/lib/mldonkey/incoming/files/

find "$FAV" -type f -mtime -700 -iname 9\* -size +600M -exec ls -rt {} \+|tail -n 100|while read ss
do
    ftemp=`basename "$ss"`
    ln -s "$ss" ~/fav/"$ftemp"
done
