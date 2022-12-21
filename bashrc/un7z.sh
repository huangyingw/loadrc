#!/bin/zsh

if [ -z "$1" ]
then
    TARGETEDIR=.
else
    TARGETEDIR="$1"
fi

find "$TARGETEDIR" -type f -iname \*.7z | \
    while read ss
    do
        echo "ss un7z --> $ss"
        ss="$(realpath "$ss")"
        cd "$(dirname "$ss")"
        7z e "$ss" && rm "$ss"
        cd -
    done
