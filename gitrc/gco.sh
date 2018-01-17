#!/bin/bash
branch="$1"
echo "branch --> $branch"

git remote update
remoteBranch=$(git branch -a | grep remotes/.*"$branch"$ | head -1 |  sed -e 's/^[ \t]*//')
localBranch=$(git branch | grep "$branch" |  sed -e 's/^[* \t]*//')

if [ -n "$localBranch" ]
then
    git checkout "$localBranch"
else
    git checkout -b "$branch" "$remoteBranch"
fi
