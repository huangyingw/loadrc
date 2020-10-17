#!/bin/zsh
COMMAND="git diff --ignore-space-at-eol -b -w --ignore-blank-lines"

if [ -z "$1" ]
then
    COMMAND="$COMMAND --cached HEAD"
else
    COMMAND="$COMMAND $1 $2"

    for ss in $(git config --get-all gdif.ignore)
    do
        COMMAND="$COMMAND  ':(exclude)$ss'"
    done
fi
eval "$COMMAND"
