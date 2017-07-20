#!/bin/bash -
function upsearch () {
    test / == "$PWD" && return || test -e "$1" && return || cd .. && upsearch "$1"
}

DIR=$(dirname "$1")
cd "$DIR"

if [ -f config ]
then
    workTree=$(cat config | awk '/worktree/{print $3}')
    if [ -z "$workTree" ];
    then
        upsearch .git
    else
        cd "$workTree"
    fi
else
    upsearch .git
fi

echo "$(realpath $(pwd))"
