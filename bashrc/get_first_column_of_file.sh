#!/bin/bash -
inputFile="$1"
#awk '{print $1}' "$inputFile" | tee "$inputFile"
cp -f "$inputFile" "$inputFile".bak
awk -F":" '{print $1}' "$inputFile".bak > "$inputFile"
sort -u "$inputFile" -o "$inputFile" 
