#! /bin/bash
if [ -f $HOME/.passwd ]; then
  FAV=`cat $HOME/.passwd |grep fav|awk '{print $3}'`
fi
rm /media/volgrp/fav/*
find "$FAV" -type f -mtime -100 -size +700M -exec ls -rt {} \+|tail -n 100|while read ss
do 
    ftemp=`basename "$ss"`
    ln -s "$ss" /media/volgrp/fav/"$ftemp"
done
