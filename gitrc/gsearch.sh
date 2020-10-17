#!/bin/zsh
find_result="$2".gsearch.findresult
echo "find_result --> $find_result"
git grep -nH -C2 "$1" $(git rev-list --all) &> "$find_result"
