#!/bin/bash
branch="$1"
echo "branch --> $branch"

git remote update
remoteBranch=$(git branch -a | grep remotes/.*"$branch"$ | head -1 |  sed -e 's/^[ \t]*//')
localBranch=$(git branch -a | grep "$branch" |  sed -e 's/^[* \t]*//')
echo "localBranch --> $localBranch"
echo "git checkout -b $localBranch $remoteBranch"

if ( git branch | grep -q "$localBranch" )
then
    git checkout "$localBranch"
else
    git checkout -b "$localBranch" "$remoteBranch"
fi

current_branch=`git branch |awk '/^\*/{print $2}'`
echo "current_branch --> $current_branch"
