#!/bin/bash -

if [ "$1" == "files.proj" ]
then
    echo "files.proj"
    exit
fi

inputFile="$1"
inputBak="$inputFile".bak
#awk '{print $1}' "$inputFile" | tee "$inputFile"
awk -F":| " '{print $1}' "$inputFile" > "$inputBak"
sed -in '/^$/d' "$inputBak"
sort -u "$inputBak" -o "$inputBak"
echo "$inputBak"
