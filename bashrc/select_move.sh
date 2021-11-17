#!/bin/zsh

cat "$1" | sed 's/^"//g;s/"$//g;s/\\ / /g' > "$1".tmp
rsync -aHv --force --progress \
    --remove-source-files \
    --files-from "$1".tmp \
    . \
    "$2"
