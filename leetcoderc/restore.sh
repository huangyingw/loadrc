#!/bin/zsh
NUM="$1"

rsync -aHv --progress \
    --exclude=*.findresult \
    --exclude=*.sw[a-z] \
    ../downloads/"$NUM"/ \
    ./"$NUM"/
