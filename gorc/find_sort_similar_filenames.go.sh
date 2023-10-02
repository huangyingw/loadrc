#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"


go build find_sort_similar_filenames.go && \
    cd /media/ && \
    /root/loadrc/gorc/find_sort_similar_filenames --file=/media/fav.log
