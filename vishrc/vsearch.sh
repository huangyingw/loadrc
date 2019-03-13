#!/bin/bash
keyword=$(echo "$2" | sed -e "s/ \+/ \\\+/g;s/\[/\\\[/g;s/\]/\\\]/g")
find_result="$4".findresult
inputFile=$(~/loadrc/bashrc/get_first_column_of_file.sh "$1")

if [[ "$3" == "w" ]]
then
    xargs grep -inH -- "$keyword" < "$inputFile" > "$find_result"
else
    cscope -dL -f cscope.out -"$3""$2" > "$find_result"
fi
