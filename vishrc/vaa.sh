#!/bin/bash
keyword=$(echo "$2" | sed -e "s/ \+/ \\\+/g;s/\[/\\\[/g;s/\]/\\\]/g")
echo "keyword --> $keyword"
find_result="$3".vaa.findresult
echo "find_result --> $find_result"
cscope_db_file=files.proj
xargs grep -inH -- "$keyword" < "$cscope_db_file" > "$find_result"
