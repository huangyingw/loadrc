#!/bin/bash
#don't know what it is used for.
#git rev-list --all | xargs git grep -wnH "$1" > "$1".gsearch.findresult
#vi "$1".gsearch.findresult
find_result="`echo "$1".gsearch.findresult |sed  -e "s/\//\_/g;s/\ /\_/g"`"
#git log -S "$1" --source --all | tee "$find_result"
git grep "$1" $(git rev-list --all) &> "$find_result" 
