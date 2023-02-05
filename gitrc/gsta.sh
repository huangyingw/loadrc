#!/bin/zsh

if [ -n "$1" ]
then
    git stash apply stash@{"$1"}
    exit 0
fi

git stash apply
