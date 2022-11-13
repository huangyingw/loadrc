#!/bin/zsh
git branch -d "$1"

for ss in $(git remote)
do
    git push "$ss" --delete "$1" || true
done
