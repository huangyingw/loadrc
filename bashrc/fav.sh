#! /bin/bash
if [ -f $HOME/.passwd ]; then
  FAV=`cat $HOME/.passwd |grep fav|awk '{print $3}'`
fi
rm ~/fav/*
find "$FAV" -type f -mtime -30 -size +700M -exec ls -t {} \+ > fav.findresult
vi fav.findresult
