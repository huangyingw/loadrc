#!/bin/zsh

source="$1"
target="$2"
mkdir -p "$(dirname "$target")"
mv -nv "$source" "$target"
