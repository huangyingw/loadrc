#!/bin/bash
if [ -z "$1" ]
then
    git diff -w --cached HEAD
else
    if [ -z "$2" ]
    then
        COMMAND="git diff -w $1"

        for ss in $(git config --get-all gdif.ignore)
        do
            COMMAND="$COMMAND  ':(exclude)$ss'"
        done

        eval "$COMMAND"
    else
        git diff -w "$1" "$2"
    fi
fi
