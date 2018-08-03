#!/bin/bash -
currentFile="$1"
rootFolder=$(~/loadrc/bashrc/find_up_folder.sh "$currentFile" "prunefile.conf")
prunefile="$rootFolder/prunefile.conf"
line="$1"
line=$(echo "$line" | sed 's/.*/"&"/')
echo "$line" >> "$prunefile"
sort -u "$prunefile" -o "$prunefile"
cd "$rootFolder"
line=$(echo "$line" | sed 's/\//\\\//g')
sed -i "/$line/d" files.proj
