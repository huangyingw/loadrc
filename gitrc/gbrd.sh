#!/bin/zsh
git branch -d "$1"
retVal=$?

if [ $retVal -eq 0 ]
then
    for ss in $(git remote)
    do
        git push "$ss" --delete "$1" || true
    done
fi
