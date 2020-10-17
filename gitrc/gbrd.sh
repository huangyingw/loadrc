#!/bin/zsh
git branch -D "$1"

if [[ $(git config --get-all push.remote) ]]
then
    for ss in $(git config --get-all push.remote)
    do
        git push "$ss" --delete "$1"
    done
fi
