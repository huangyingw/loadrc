#!/bin/zsh

~/loadrc/gitrc/include_gitconfig.sh

git_directory=$(git rev-parse --git-dir)

commit_message=""

if [ -n "$1" ]; then
    commit_message="$1"
elif [ -f "$git_directory/MERGE_MSG" ] && [ -s "$git_directory/MERGE_MSG" ]; then
    commit_message=$(cat "$git_directory/MERGE_MSG")
elif [ -f "$git_directory/COMMIT_EDITMSG" ]; then
    commit_message=$(cat "$git_directory/COMMIT_EDITMSG")
fi

if [ -z "$commit_message" ]; then
    commit_message="n"
fi

git commit --no-edit || git commit -m "$commit_message"

~/loadrc/gitrc/postCommit.sh
