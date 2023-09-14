#!/bin/zsh
if [ -z "$1" ]
then
    git stash show -p stash@{0} | git apply --reject --whitespace=fix --recount && git stash drop stash@{0}
else
    git stash show -p stash@{"$1"} | git apply --reject --whitespace=fix --recount && git stash drop stash@{"$1"}
fi
