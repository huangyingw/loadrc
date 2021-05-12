#!/bin/zsh
FILE="$1"

~/loadrc/leetcoderc/submit.sh "$FILE"
NUM=$(echo "$FILE" | sed 's/.*\/\([0-9]*\)\..*/\1/g') 
~/loadrc/bashrc/check_running.sh ~/loadrc/leetcoderc/submission.sh "$NUM"
~/loadrc/leetcoderc/restore.sh "$NUM"
