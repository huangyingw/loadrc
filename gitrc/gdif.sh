#!/bin/zsh

COMMAND="git diff --ignore-space-at-eol -b -w --ignore-blank-lines HEAD $1"

while read ss
do
    if [ -f "$ss" ]
    then
        COMMAND="$COMMAND  '$ss'"
    fi
done < "$2"

eval "$COMMAND"
