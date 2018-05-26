#! /bin/bash
FAV=/home/parallels/movie/media/volgrp/av/
rm ~/fav/*
find "$FAV" -type f -mtime -700 -iname 9\* -size +600M -exec ls -rt {} \+|tail -n 100|while read ss
do
    ftemp=`basename "$ss"`
    ln -s "$ss" ~/fav/"$ftemp"
done
