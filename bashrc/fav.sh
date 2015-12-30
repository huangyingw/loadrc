#! /bin/bash
if [ `hostname` == "mbuntu" ]
then
  if [ -f $HOME/loadrc/.passwd ]; then
    FAV=`cat $HOME/loadrc/.passwd |grep fav|awk '{print $3}'`
  fi
  rm ~/fav/*
  find "$FAV" -type f -mtime -700 -iname 9\* -size +600M -exec ls -rt {} \+|tail -n 100|while read ss
do 
  ftemp=`basename "$ss"`
  ln -s "$ss" ~/fav/"$ftemp"
done
else
  if [ -z "$1" ];
  then
    FAV=`cat $HOME/loadrc/.passwd |grep fav|awk '{print $3}'`
  else
    FAV="$1"
  fi
  find "$FAV" -type f -mtime -30 -iname 9\* -exec ls -t {} \+ > fav.findresult
  vi fav.findresult
fi
