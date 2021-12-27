#!/bin/zsh
NUM="$1"

rsync -aHv --progress \
    ../downloads/"$NUM"/ \
    ../submissions/"$NUM"/
