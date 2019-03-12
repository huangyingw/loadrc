#!/bin/bash
find_result="`echo "$2".findresult |sed  -e "s/\//\_/g;s/\ /\_/g"`"
echo "result in " "$find_result"

if [[ "$3" == "w" ]]
then
    xargs grep -inH "$2" < "$1" > "$find_result"
else
    cscope -dL -f cscope.out -"$3""$2" > "$find_result"
fi
