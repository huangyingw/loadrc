#! /bin/bash

FAV=/media/volgrp/mirror/av/

if [ -d "$FAV" ]
then
    cd "$FAV"

    find . -type f -size +100M -exec ls -t {} \+ > fav.log
    touch files.proj
    . ~/loadrc/bashrc/cscope.sh
fi

FAV=/home/parallels/server/media/volgrp/mirror/av/

if [ -d "$FAV" ]
then
    rm ~/fav/*
    find "$FAV" -type f -mtime -700 -iname 9\* -size +600M -exec ls -rt {} \+|tail -n 100 | while read ss \
    do \
        ftemp=`basename "$ss"`; \
        ln -s "$ss" ~/fav/"$ftemp"; \
    done
fi
