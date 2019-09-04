#!/bin/bash
keyword=$(echo "$2" | sed -e "s/ \+/ \\\+/g;s/\[/\\\[/g;s/\]/\\\]/g;s/\\\c//g;s/\\\V//g")
find_result="$4".findresult
inputFile=$(~/loadrc/bashrc/get_first_column_of_file.sh "$1")

cscope -dL -f cscope.out -"$3""$2" > "$find_result"
