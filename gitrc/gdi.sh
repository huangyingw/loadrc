#!/bin/bash
if [ -z "$1" ]
then
    git diff -U10 -w --cached HEAD
else
    if [ -z "$2" ]
    then
        COMMAND="git diff -U10 -w $1"

        for ss in $(git config --get-all gdif.ignore)
        do
            COMMAND="$COMMAND  ':(exclude)$ss'"
        done

        eval "$COMMAND"
    else
        git diff -U10 -w "$1" "$2"
    fi
fi
