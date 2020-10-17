#!/bin/zsh
branch="$1"
echo "branch --> $branch"

git remote update
remoteBranch=$(~/loadrc/gitrc/get_remote_branch.sh "$branch")
localBranch=$(git branch | grep "$branch" |  sed -e 's/^[* \t]*//')

if [ -n "$localBranch" ]
then
    git checkout "$localBranch"
elif [ -n "$remoteBranch" ]
then
    git checkout -b "$branch" "$remoteBranch"
fi
