#!/bin/zsh
FILE="$1"
NUM=$(echo "$FILE" | sed 's/^\([0-9]*\)\..*/\1/g')

~/loadrc/bashrc/run_once_script_checker.sh ~/loadrc/leetcoderc/do_post_submit.sh "$NUM"
