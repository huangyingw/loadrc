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

# Initialize commit message variable
commit_message=""

# Check if there is an ongoing merge
if [ -f "$git_directory/MERGE_MSG" ] && [ -s "$git_directory/MERGE_MSG" ]; then
    commit_message=$(cat "$git_directory/MERGE_MSG")
    # Check if there is a COMMIT_EDITMSG file
elif [ -f "$git_directory/COMMIT_EDITMSG" ]; then
    commit_message=$(cat "$git_directory/COMMIT_EDITMSG")
fi

# Use the first argument as the commit message if provided
if [ -n "$1" ]; then
    commit_message="$1"
fi

# Use a default commit message if none is set
if [ -z "$commit_message" ]; then
    commit_message="n"
fi

# Try committing without editing the message or use the provided message
git commit --no-edit || git commit -m "$commit_message"

# Run post-commit script
~/loadrc/gitrc/postCommit.sh

# Empty the COMMIT_EDITMSG and MERGE_MSG files after a successful commit
if [ -f "$git_directory/COMMIT_EDITMSG" ]; then
    echo "" > "$git_directory/COMMIT_EDITMSG"
fi

if [ -f "$git_directory/MERGE_MSG" ]; then
    echo "" > "$git_directory/MERGE_MSG"
fi
