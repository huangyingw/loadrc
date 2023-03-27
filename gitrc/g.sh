#!/bin/zsh
~/loadrc/gitrc/include_gitconfig.sh

git_dir=$(git rev-parse --git-dir)

if [ -f "$git_dir/MERGE_MSG" ] && [ -s "$git_dir/MERGE_MSG" ]
then
    commit_message=$(cat "$git_dir/MERGE_MSG")
elif [ -f "$git_dir/COMMIT_EDITMSG" ]
then
    commit_message=$(cat "$git_dir/COMMIT_EDITMSG")
fi

if [ -n "$1" ]
then
    commit_message="$1"
fi

if [ -z "$commit_message" ]
then
    commit_message="n"
fi

git commit --no-edit || \
    git commit -m "$commit_message"

~/loadrc/gitrc/postCommit.sh
