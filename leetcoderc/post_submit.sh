#!/bin/zsh
NUM="$1"

~/loadrc/bashrc/check_running.sh ~/loadrc/leetcoderc/submission.sh "$NUM"
~/loadrc/leetcoderc/restore.sh "$NUM"
~/loadrc/leetcoderc/remove_dup.sh "$NUM"
