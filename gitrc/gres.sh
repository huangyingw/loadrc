#!/bin/zsh

IFS=$'\n'
conflictArr=($(git status | awk '/both .+:/{print $3}'))

for conflict in "${conflictArr[@]}"
do
    git add $conflict
    git reset HEAD $conflict
done
