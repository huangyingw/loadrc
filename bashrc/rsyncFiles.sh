#!/bin/bash -
cat files.proj | sed 's/^"//g;s/"$//g;s/\\ / /g' > files.proj.tmp && \
    rsync -aHv --force --progress \
    --files-from files.proj.tmp \
    "$1" \
    "$2"
