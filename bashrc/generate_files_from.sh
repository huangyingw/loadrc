#!/bin/zsh

cat files.proj | sed 's/^"//g;s/"$//g;s/\\ / /g' > files.from
