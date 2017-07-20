#!/bin/bash -
configFile=$(echo "$1" | sed 's/index$/config/')
workTree=$(cat "$configFile" | awk '/worktree/{print $3}')
if [ -z "$workTree" ];
then
    echo "$(realpath "$1"/../)"
else
    workTreeRelative=$(echo "$workTree" | sed 's/index$//')
    echo "$(realpath $(echo "$1" | sed 's/index$//')"$workTreeRelative")"
fi
