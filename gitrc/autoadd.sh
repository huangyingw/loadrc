#!/bin/bash -
fileName="$1"

if [[ -d .git || -f .git ]] && [[ -f files.proj ]]
then
    if grep -q "$fileName" files.proj
    then
        git add -f "$fileName"
    fi
fi
