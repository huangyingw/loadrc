#!/bin/zsh

IFS=$'\n'
conflictArr=($(git status | awk '/both (modified|added):/ { sub(/both (modified|added):[[:space:]]*/, ""); print }'))

# Remove leading and trailing whitespaces from each element in conflictArr
for i in {1..${#conflictArr[@]}}; do
    conflictArr[i]=$(echo "${conflictArr[i]}" | xargs)
done

for conflict in "${conflictArr[@]}"
do
    git restore --staged "$conflict"
done
