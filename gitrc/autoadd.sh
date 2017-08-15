#!/bin/bash -
fileName="$1"

if grep -q "$fileName" files.proj
then
    git add -f "$fileName"
fi
