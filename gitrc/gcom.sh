#!/bin/zsh

# Check if gcom is disabled
if [[ "$(git config gcom.disabled)" = "true" ]]; then
    echo -e "${RED}gcom is disabled... ${NC}"
    exit 1
fi

# Check if target_branch is provided
if [ -z "$1" ]; then
    echo -e "${RED}Please provide target_branch... ${NC}"
    exit 1
fi

# Retrieve the current branch and target branch
current_branch=$(~/loadrc/gitrc/get_current_branch.sh)
target_branch="$1"
target_branch=$(echo "$target_branch" | sed 's/remotes\///g')

# Remove remote prefix from target_branch
for remote in $(git remote); do
    target_branch=$(echo "$target_branch" | sed "s/^$remote\///g")
done

echo "TARGET_BRANCH --> $target_branch"

# Perform branch operations
git branch -d "$target_branch"
git checkout -b "$target_branch" 2> /dev/null || git checkout "$target_branch"
~/loadrc/gitrc/merge_with_resolution.sh "$current_branch"

# Merge target branch and run gpl script
~/loadrc/gitrc/merge_with_resolution.sh "$1"
~/loadrc/gitrc/gpl.sh
