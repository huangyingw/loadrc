#!/bin/bash -
currentFile="$1"
echo "currentFile --> $currentFile"
prunefile=$(~/loadrc/bashrc/find_up.sh "$currentFile" "prunefile.conf")
echo "prunefile --> $prunefile"
echo realpath --relative-to="$prunefile" "$currentFile"
realpath --relative-to="$prunefile" "$currentFile"
realpath --relative-base="$prunefile" "$currentFile"
