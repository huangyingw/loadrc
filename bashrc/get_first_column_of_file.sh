#!/bin/bash -

if [ "$1" == "files.proj" ]
then
    echo "files.proj"
    return
fi

inputFile="$1"
#awk '{print $1}' "$inputFile" | tee "$inputFile"
awk -F":| " '{print $1}' "$inputFile" > "$inputFile".bak
sort -u "$inputFile".bak -o "$inputFile".bak
echo "$inputFile".bak
