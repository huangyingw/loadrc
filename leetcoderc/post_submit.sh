#!/bin/zsh
FILE="$1"
NUM=$(echo "$FILE" | sed 's/^\([0-9]*\)\..*/\1/g')

~/loadrc/leetcoderc/submission.sh "$NUM"
~/loadrc/leetcoderc/restore.sh "$NUM"
~/loadrc/leetcoderc/remove_dup.sh "$NUM"
