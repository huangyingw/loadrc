#!/bin/bash -
rsync -aHv --force --progress \
    --files-from files.proj.tmp \
    "$1" \
    "$2"
