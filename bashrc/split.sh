#!/bin/zsh
gsplit -l 1 --numeric-suffixes --additional-suffix=.json "$1" "$1"
find . -type f -name "$1*.json" -exec js-beautify -r {} \;
