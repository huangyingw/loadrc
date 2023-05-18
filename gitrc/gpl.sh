#!/bin/zsh

# Discard unnecessary files
~/loadrc/gitrc/discard_unnecessaries.sh

# Include git configuration
~/loadrc/gitrc/include_gitconfig.sh

# Update remote references
git remote update

# Get the current branch name
currentBranch=$(~/loadrc/gitrc/get_current_branch.sh)

# Function to pull and prune a remote
pull_and_prune() {
    git pull $1 $2
    git remote prune $1
}

# Iterate through remotes and perform pull and prune operations in parallel
for remote in $(git remote); do
    pull_and_prune $remote $currentBranch &
done

# Wait for all background processes to finish
wait

# Merge branches specified in the 'merge.from' configuration
for ss in $(git config --get-all merge.from); do
    ~/loadrc/gitrc/merge_with_resolution.sh "$ss"
done

# Get the 'gsync.target' configuration value
target=$(git config gsync.target)

# Merge the target branch if specified
if [ -n "$target" ]; then
    ~/loadrc/gitrc/merge_with_resolution.sh "$target"
fi
