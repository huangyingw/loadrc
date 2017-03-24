#!/bin/bash
branch="$1"

git remote update
remoteBranch=$(git branch -a | grep remotes/.*"$branch"$ | head -1 |  sed -e 's/^[ \t]*//')
localBranch=$(git branch -a | grep "$branch" | sed 's/.*\///;s/^\*[ \t]*//' | head -1)
echo "remoteBranch --> $remoteBranch"
echo "localBranch --> $localBranch"
echo "git checkout -b $localBranch $remoteBranch"

git checkout -b "$localBranch" "$remoteBranch"
current_branch=`git branch |awk '/^\*/{print $2}'`
echo "current_branch --> $current_branch"
