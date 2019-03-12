#!/bin/bash -
inputFile="$1"
#awk '{print $1}' "$inputFile" | tee "$inputFile"
awk -F":" '{print $1}' "$inputFile" > "$inputFile".bak
