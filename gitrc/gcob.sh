#!/bin/zsh
if [ -z "$1" ]
then
    echo -e "${red}Please provide the new branch name ... ${NC}"
    exit 1
fi

branch="$1"
currentBranch=$(~/loadrc/gitrc/get_current_branch.sh)
git remote update

if [ -n "$2" ]
then
    git checkout -b "$branch" "$2"
else
    remoteBranch=$(~/loadrc/gitrc/get_remote_branch.sh "$branch")

    if [ -n "$remoteBranch" ]
    then
        git checkout -b "$branch" "$remoteBranch"
    else
        git checkout -b "$branch"
    fi
fi

git checkout "$branch"
git merge "$currentBranch"
