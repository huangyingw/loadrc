#!/bin/zsh
branch="$1"
for remote in $(git remote)
do
    if [ -n "$(git ls-remote --heads $remote $1)" ]
    then
        echo "$remote/$branch"
        exit 0
    fi
done
