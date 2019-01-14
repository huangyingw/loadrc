#!/bin/bash
keyword=$(echo "$2" | sed -e "s/ \+/ \\\+/g;s/\[/\\\[/g;s/\]/\\\]/g")
echo "keyword --> $keyword"
echo "search in " "$1"
cd "$1"
find_result="$3".vaa.findresult
echo "find_result --> $find_result"
cscope_db_file=files.proj
echo "result in " "$1/$find_result"
xargs grep -inH -- "$keyword" < "$cscope_db_file" > "$find_result"
