#!/bin/bash
branch="$1"
echo "branch --> $branch"

git remote update
remoteBranch=$(~/loadrc/gitrc/get_remote_branch.sh)
localBranch=$(git branch | grep "$branch" |  sed -e 's/^[* \t]*//')

if [ -n "$localBranch" ]
then
    git checkout "$localBranch"
else
    git checkout -b "$branch" "$remoteBranch"
fi
