#! /bin/bash
if [ -f $HOME/.passwd ]; then
  FAV=`cat $HOME/.passwd |grep fav|awk '{print $3}'`
fi
rm /media/volgrp/flarge/*
find "$FAV" -type f -size +4000M -name 9\* |while read ss
do 
    ftemp=`basename "$ss"`
    ln -s "$ss" /media/volgrp/flarge/"$ftemp"
done
