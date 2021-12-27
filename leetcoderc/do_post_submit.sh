#!/bin/zsh
NUM="$1"

~/loadrc/leetcoderc/submission.sh "$NUM"
~/loadrc/leetcoderc/restore.sh "$NUM"
~/loadrc/leetcoderc/remove_dup.sh "$NUM"
