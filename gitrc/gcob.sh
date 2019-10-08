#!/bin/bash
if [ -z "$1" ]
then
    echo -e "${red}Please provide the new branch name ... ${NC}"
    exit 1
fi
if [ -n "$2" ]
then
    git checkout -b "$1" "$2"
else
    for remote in $(git remote)
    do
        if [ -n "$(git ls-remote --heads $remote $1)" ]
        then
            git checkout -b "$1" "$remote/$1"
            exit 0
        fi
    done
    git checkout -b "$1"
fi
