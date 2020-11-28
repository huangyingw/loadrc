#!/bin/zsh
DIR=$(dirname "$1")
cd "$DIR"

if [ -f config ]
then
    workTree=$(cat config | awk '/worktree =/{print $3}')
    if [ -z "$workTree" ]
    then
        . ~/loadrc/bashrc/find_up_goto.sh .git
    else
        cd "$workTree"
    fi
else
    . ~/loadrc/bashrc/find_up_goto.sh .git
fi

realpath "$(pwd)"
