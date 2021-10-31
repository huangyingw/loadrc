#!/bin/zsh

source=$(echo "$1" | sed 's/"//g')
target=$(~/loadrc/bashrc/append_num.sh "$1" "$2")
mkdir -p "$(dirname "$target")"
mv -nv "$source" "$target"
