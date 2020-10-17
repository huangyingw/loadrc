#!/bin/zsh
while true
do
    cat "$1" | sed 's/^"//g;s/"$//g;s/\\ / /g' > "$1".tmp
    rsync -aHv --force --progress \
        --files-from "$1".tmp \
        "$2" \
        "$3"
done
