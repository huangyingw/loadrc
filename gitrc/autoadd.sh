#!/bin/bash -
fileName="$1"
filesProj=$(~/loadrc/bashrc/find_up.sh $(pwd) "files.proj")

if [ grep -q "$fileName" "$filesProj" ] && [ ! git ls-files --error-unmatch "$fileName" ]
then
    git add -f "$fileName"
fi
