#!/bin/bash - 
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

find . "(" "${prune_params[@]}" "${prune_files[@]}" ")" -a -prune -o -type f -print -exec file {} \; | grep text | cut -d: -f1
