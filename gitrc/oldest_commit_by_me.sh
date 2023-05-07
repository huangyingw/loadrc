#!/bin/zsh

# Get your Git user name and email
git_user_name=$(git config user.name)
git_user_email=$(git config user.email)

# Get the oldest commit by you in the current repository
oldest_commit_by_you=$(git rev-list --all --author="$git_user_name <$git_user_email>" | tail -n 1)

# Print the oldest commit by you
echo "The oldest commit by you ($git_user_name) in the current repository is: $oldest_commit_by_you"
