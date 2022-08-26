#! /bin/zsh

FAV=/media/volgrp/mirror1/av/

if [ -d "$FAV" ]
then
    cd "$FAV"
    find . -type f -size +10M -exec du -h {} + | sort -r -h | cut -f 2 | sed 's/\(["\]\)/\\\1/g;s/.*/"&"/' > fav.log 
    find . -type f -size +10M -exec ls -t {} \+ | sed 's/\(["\]\)/\\\1/g;s/.*/"&"/' > fav.log.sort
    touch files.proj
    cd -
fi

~/loadrc/bashrc/fvideos.sh
