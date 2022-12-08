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
        echo "ss unrar --> $ss"
        ss="$(realpath "$ss")"
        cd "$(dirname "$ss")"
        unrar x -r -p- -o+ "$ss" && rm "$ss"
        cd -
    done
