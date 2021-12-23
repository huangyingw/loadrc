#!/bin/zsh
keyword=$(echo "$2" | sed -e "s/ \+/ \\\+/g;s/\[/\\\[/g;s/\]/\\\]/g;s/\\\c//g;s/\\\V//g")
find_result="$4".findresult
inputFile=$(~/loadrc/bashrc/get_first_column_of_file.sh "$1")

if [[ "$3" == "w" ]]
then
    xargs grep -inH -- "$keyword" < "$inputFile" > "$find_result"
else
    cscope -CdL -f cscope.out -"$3""$keyword" > "$find_result"
fi

awk 'BEGIN{FS=OFS=":"} {gsub(/ /,"\\\\&",$1)} 1' "$find_result" > "$find_result".bak
cp -fv "$find_result".bak "$find_result"
