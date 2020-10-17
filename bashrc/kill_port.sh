#!/bin/zsh
if [ -n "$1" ]
then
    lsof -i :"$1" | awk 'NR > 1 {print $2}' | while read ss; do kill -9 "$ss"; done
fi
