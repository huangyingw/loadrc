#!/bin/zsh

source="$1"
target="$2"

echo "ss --> $ss"
echo "target --> $target"

find "$source" -type f | \
    while read ss
    do
        new_ss=$(echo "$ss" | sed -e "s#$source#$target#g")
        mkdir -p "$(dirname "$new_ss")"
        mv -v "$ss" "$new_ss"
    done
