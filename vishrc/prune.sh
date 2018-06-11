#!/bin/bash -
currentFile="$1"
rootFolder=$(~/loadrc/bashrc/find_up_folder.sh "$currentFile" "prunefile.conf")
prunefile="$rootFolder/prunefile.conf"
line=$(realpath --relative-to="$rootFolder" "$currentFile")
line=$(echo "$line" | sed 's/.*/"&"/')
echo "$line" >> "$prunefile"
sort -u "$prunefile" -o "$prunefile"
~/loadrc/bashrc/cscope.sh
