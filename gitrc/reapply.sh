#!/bin/zsh
DIFF="$1"
git apply --reverse "$DIFF" 
git checkout -- "$DIFF"
git apply --reject --whitespace=fix "$DIFF"
