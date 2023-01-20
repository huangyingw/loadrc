#!/bin/zsh

IFS=$'\n'
conflictArr=($(git status | sed -e '/both modified:/!d;s/both modified:\s*//;s/^[[:space:]]*//g'))

for conflict in "${conflictArr[@]}"
do
    git add "$conflict"
    git reset HEAD "$conflict"
done
