#!/bin/zsh

if [ -z "$1" ]
then
    echo -e "${red}Please provide target_branch... ${NC}"
    exit 1
fi

clean=$(git status --porcelain)

if [ -n "$clean" ]
then
    git stash
fi

~/loadrc/gitrc/discard_unnecessaries.sh
current_branch=$(~/loadrc/gitrc/get_current_branch.sh)

TARGET_BRANCH="$1"
TARGET_BRANCH=$(echo "$TARGET_BRANCH" | sed 's/remotes\///g')
TARGET_BRANCH="$TARGET_BRANCH"

for remote in $(git remote)
do
    TARGET_BRANCH=$(echo "$TARGET_BRANCH" | sed "s/^$remote\///g")
done

echo "TARGET_BRANCH --> $TARGET_BRANCH"

git checkout -b "$TARGET_BRANCH" || \
    git checkout "$TARGET_BRANCH" &&
    git merge "$current_branch"

git merge "$1"
~/loadrc/gitrc/gpl.sh

if [ -n "$clean" ]
then
    git stash pop stash@{0}
fi
