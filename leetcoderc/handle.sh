#!/bin/zsh
FILE="$1"
# ~/loadrc/leetcoderc/submit.sh "$FILE"
NUM=$(echo "$FILE" | sed 's/.*\/\([0-9]*\)\..*/\1/g') 
echo "NUM --> $NUM"
leetcode submission "$NUM" -o downloads
