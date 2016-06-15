#!/bin/bash
find_result="`echo "$1".gsearch.findresult |sed  -e "s/\//\_/g;s/\ /\_/g"`"
git grep "$1" $(git rev-list --all) &> "$find_result" 
