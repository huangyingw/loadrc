#!/bin/bash -
fileName="$1"

if (cat files.proj | grep -q "$fileName")
then
    git add -f "$fileName"
fi
