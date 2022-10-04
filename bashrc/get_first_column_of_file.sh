#!/bin/zsh

if [ "$1" = "files.proj" ]
then
    echo "files.proj"
    exit
fi

inputFile="$1"
inputBak="$inputFile".tmp
awk -F":" '{print $1}' "$inputFile" > "$inputBak"
sed -i.bak "/^$/d" "$inputBak"
sort -u "$inputBak" -o "$inputBak"
echo "$inputBak"
