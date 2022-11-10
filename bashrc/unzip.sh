#!/bin/zsh

if [ -z "$1" ]
then
    TARGETEDIR=.
else
    TARGETEDIR="$1"
fi

find "$TARGETEDIR" -type f -iname \*.zip | \
    while read ss
    do
        echo "ss unzip --> $ss"
        unzip -n -d "$(echo "$ss"|sed 's/\.zip$//g')" "$ss" && \
            rm "$ss"
        done
