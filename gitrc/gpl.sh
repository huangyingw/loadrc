#!/bin/zsh

# Discard unnecessary files
~/loadrc/gitrc/discard_unnecessaries.sh

# Check for changes in the working directory
changes=$(git status --untracked-files=no --porcelain --ignore-submodules)

if [ -n "$changes" ]; then
    return
fi

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

# Get the 'gsync.target' configuration value
target=$(git config gsync.target)

# Merge the target branch if specified
if [ -n "$target" ]; then
    ~/loadrc/gitrc/merge_with_resolution.sh "$target"
fi
