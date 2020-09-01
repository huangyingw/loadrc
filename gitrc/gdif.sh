#!/bin/zsh

COMMAND="git diff --ignore-space-at-eol -b -w --ignore-blank-lines HEAD $1"

while read ss
do
    COMMAND="$COMMAND  -- '$ss'"
done < "$2"

eval "$COMMAND"
