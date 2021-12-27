#!/bin/zsh
NUM="$1"
cd "$NUM"

~/loadrc/leetcoderc/remove_gabages.sh
find . -type f \( -name \*.orig -o -name \*.bak \) -delete
jdupes -1dNr .
