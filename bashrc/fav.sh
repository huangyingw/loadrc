#! /bin/zsh

FAV=/media/volgrp/mirror1/av/

if [ -d "$FAV" ]
then
    cd "$FAV"

    find . -type f -size +10M -exec du -h {} + | sort -r -h | cut -f 2 > fav.log 
    find . -type f -size +10M -exec ls -t {} \+ > fav.log.sort
    touch files.proj
fi
