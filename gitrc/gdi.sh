#!/bin/bash
if [ -z "$1" ]
then
    git diff -w --cached HEAD | tee gdi.findresult
else
    COMMAND="git diff -w --cached $1"

    for ss in $(git config --get-all gdif.ignore)
    do
        COMMAND="$COMMAND  ':(exclude)$ss'"
    done

    eval "$COMMAND" | tee gdi.findresult
fi
