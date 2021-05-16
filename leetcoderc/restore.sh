#!/bin/zsh
NUM="$1"

rsync -aHv --progress \
    --ignore-existing \
    ../downloads/"$NUM"/ \
    ./"$NUM"/
