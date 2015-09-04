#! /bin/bash
if [ -z "$1" ];
then
  FAV=`cat $HOME/.passwd |grep fav|awk '{print $3}'`
else
  FAV="$1"
fi
find "$FAV" -type f -mtime -30 -iname 9\* -exec ls -t {} \+ > fav.findresult
vi fav.findresult
