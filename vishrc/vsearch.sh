#!/bin/bash
keyword=$(echo "$2" | sed -e "s/ \+/ \\\+/g;s/\[/\\\[/g;s/\]/\\\]/g")
find_result="$4".findresult

if [[ "$3" == "w" ]]
then
    xargs grep -inH -- "$keyword" < "$1" > "$find_result"
else
    cscope -dL -f cscope.out -"$3""$2" > "$find_result"
fi
