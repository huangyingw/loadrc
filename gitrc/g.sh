#!/bin/zsh

# Include git configuration
~/loadrc/gitrc/include_gitconfig.sh

# Get the Git directory
git_directory=$(git rev-parse --git-dir 2>/dev/null)

# Check if the command was successful
if [ $? -ne 0 ]; then
    echo "Error: Not a Git repository or any of the parent directories."
    exit 1
fi

# Use the first argument as the commit message if provided
if [ -n "$1" ]; then
    git commit -m "$1"
else
    git commit --no-edit
fi

# Run post-commit script
~/loadrc/gitrc/postCommit.sh
