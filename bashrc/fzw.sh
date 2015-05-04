#! /bin/bash
if [ -f $HOME/.passwd ]; then
  FAV=`cat $HOME/.passwd |grep fav|awk '{print $3}'`
fi
rm /media/volgrp/fzw/*
find "$FAV" -type f -size +400M -name 9\*中文\* |while read ss
do 
    ftemp=`basename "$ss"`
    ln -s "$ss" /media/volgrp/fzw/"$ftemp"
done
