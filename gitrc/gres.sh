#!/bin/zsh

conflictArr=($(git status | awk '/both .+:/{print $3}'))
IFS=$'\n'

for conflict in "${conflictArr[@]}"
do
    git add $conflict
    git reset HEAD $conflict
done
