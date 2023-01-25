#!/bin/zsh

~/loadrc/gitrc/discard_unnecessaries.sh
git remote update
TARGET_BRANCH="$1"
TARGET_BRANCH=$(echo "$TARGET_BRANCH" | sed 's/remotes\///g')
TARGET_BRANCH="$TARGET_BRANCH"

for remote in $(git remote)
do
    TARGET_BRANCH=$(echo "$TARGET_BRANCH" | sed "s/^$remote\///g")
done

echo "TARGET_BRANCH --> $TARGET_BRANCH"

remoteBranch=$(~/loadrc/gitrc/get_remote_branch.sh "$TARGET_BRANCH")
echo "remoteBranch --> $remoteBranch"
localBranch=$(git branch | grep "$TARGET_BRANCH" |  sed -e 's/^[* ]*//')
echo "localBranch --> $localBranch"

if [ -n "$localBranch" ]
then
    git checkout "$localBranch"
elif [ -n "$remoteBranch" ]
then
    git checkout -b "$TARGET_BRANCH" "$remoteBranch"
fi
