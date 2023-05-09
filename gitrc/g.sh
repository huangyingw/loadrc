#!/bin/zsh

# Get the commit message
commit_message=$(~/loadrc/gitrc/get_commit_message.sh)

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
git_directory=$(git rev-parse --git-dir 2>/dev/null)
if [ -f "$git_directory/COMMIT_EDITMSG" ]; then
    echo "" > "$git_directory/COMMIT_EDITMSG"
fi

if [ -f "$git_directory/MERGE_MSG" ]; then
    echo "" > "$git_directory/MERGE_MSG"
fi
