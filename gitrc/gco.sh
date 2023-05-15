#!/bin/zsh

# Load necessary scripts
~/loadrc/gitrc/discard_unnecessaries.sh

# Update remote references
git remote update

# Process the target branch name
TARGET_BRANCH="$1"
TARGET_BRANCH=$(echo "$TARGET_BRANCH" | sed 's/remotes\///g')

# Remove remote name from target branch name
for remote in $(git remote)
do
    TARGET_BRANCH=$(echo "$TARGET_BRANCH" | sed "s/^$remote\///g")
done

echo "TARGET_BRANCH --> $TARGET_BRANCH"

# Get the corresponding remote branch
remoteBranch=$(~/loadrc/gitrc/get_remote_branch.sh "$TARGET_BRANCH")
echo "remoteBranch --> $remoteBranch"

# Try to delete TARGET_BRANCH, will continue regardless of success
git branch -d "$TARGET_BRANCH"

# Try to checkout to a new branch, if it fails then checkout to the existing branch
git checkout -b "$TARGET_BRANCH" "$remoteBranch" \
    || git checkout "$TARGET_BRANCH"
