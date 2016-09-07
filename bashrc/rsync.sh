#!/bin/bash - 
rsync -aHv --delete --force --progress \
    --exclude-from="excludeFile" \
    "$1" \
    "$2"
