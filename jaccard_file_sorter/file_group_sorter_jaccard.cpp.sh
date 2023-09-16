#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

make && \            
    make install && \
    /usr/local/bin/file_group_sorter_jaccard "/media/115_disk/av/kyler/fav.log" "/media/115_disk/av/kyler/fav.log.dup"
