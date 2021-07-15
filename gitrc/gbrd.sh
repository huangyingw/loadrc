#!/bin/zsh
git branch -D "$1"

for ss in $(git remote)
do
    git push "$ss" --delete "$1" || true
done
