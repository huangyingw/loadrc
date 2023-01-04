#!/bin/zsh

conflictArr=($(git status | awk '/both .+:/{print $3}'))
#        git status | sed -e '/both modified:/!d;s/both modified://;s/^[\s\t]*//g;s/\ /\\ /g'
#        both modified:   dev.gdio.diff
for conflict in "${conflictArr[@]}"
do
    git add $conflict
    git reset HEAD $conflict
done
