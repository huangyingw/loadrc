#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"


go build file_group_sorter_jaccard.go && \
    ./file_group_sorter_jaccard "/media/fav.log" "/media/fav.log.dup"
