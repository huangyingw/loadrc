#!/bin/bash - 
inputFile="$1"
awk '{print $1}' "$inputFile" | tee "$inputFile"
