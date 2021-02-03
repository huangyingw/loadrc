#!/bin/zsh
gsplit -l 1 --numeric-suffixes --additional-suffix=.json "$1" "$1"
export LC_ALL=C
find . -type f -name "$1*.json" -exec js-beautify -r {} \; 
