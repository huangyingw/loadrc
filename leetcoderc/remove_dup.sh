#!/bin/zsh
NUM="$1"
cd "$NUM"

git checkout .
~/loadrc/leetcoderc/remove_gabages.sh
find . -type f \( -name \*.orig -o -name \*.bak \) -delete
jdupes -1dNr .
