#!/bin/bash
echo "search in " "$1"
cd "$1"
find_result="$1/""`echo "$2"."$4".findresult |sed  -e "s/\//\_/g;s/\ /\_/g"`"
cscope_db_file=files.proj
echo "result in " "$find_result"
xargs fgrep -wnH "$2" < "$cscope_db_file" > "$find_result"
