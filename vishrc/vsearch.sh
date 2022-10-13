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

# https://stackoverflow.com/questions/70444758/how-to-regex-replace-before-colon
# awk 'BEGIN {FS=OFS=":"}{if(NF>1)gsub(" ","\\ ",$1)}1' "$find_result" > "$find_result".bak
# perl -pe 's/\G[^ :]*\K /\\ /g' "$find_result" > "$find_result".bak
# sed -i.bak -E 's/:/\n:/;h;s/ /\\ /g;G;s/\n.*\n//' "$find_result"
awk 'BEGIN {FS=OFS=":"}{if(NF>1)gsub(" ","\\ ",$1)}1' "$find_result" > "$find_result".tmp
awk 'BEGIN {FS=OFS=":"}{if(NF<=1)gsub(" ","\\ ",$1)}1' "$find_result".tmp > "$find_result"
