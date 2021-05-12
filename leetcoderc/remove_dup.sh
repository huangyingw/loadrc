#!/bin/zsh

while true
do
    ~/loadrc/leetcoderc/remove_gabages.sh
    find . -type f \( -name \*.orig -o -name \*.bak \) -delete
    jdupes -1dNr submissions/
done
