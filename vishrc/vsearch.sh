#!/bin/bash
echo "search in " "$1"
cd "$1"
find_result="$1/""`echo "$2"."$4".findresult |sed  -e "s/\//\_/g;s/\ /\_/g"`"
echo "result in " "$find_result"
cscope -dL -f cscope.out -"$3""$2" > "$find_result"
