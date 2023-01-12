#!/bin/zsh

SOURCE="$1"
TARGET="$2"


find "$SOURCE" -type f | \
    while read ss
    do
        new_ss=$(echo "$ss" | sed -e "s#$SOURCE#$TARGET#g")
        mkdir -p "$(dirname "$new_ss")"
        mv -nv "$ss" "$new_ss"
    done
