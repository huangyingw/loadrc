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

echo "$commit_message"
