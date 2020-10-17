#!/bin/zsh

if [ -z "$1" ]
then
    TARGETEDIR=.
else
    TARGETEDIR="$1"
fi

find "$TARGETEDIR" -type d -empty -delete
rmdir "$TARGETEDIR"
