#!/bin/bash -
fileName="$1"
filesProj=$(~/loadrc/bashrc/find_up.sh $(pwd) "files.proj")

if [[ -d .git || -f .git ]]
then
    if grep -q "$fileName" "$filesProj"
    then
        git add -f "$fileName"
    fi
fi
