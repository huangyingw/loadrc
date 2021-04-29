#!/bin/zsh
current_branch="$(~/loadrc/gitrc/get_current_branch.sh)"
target_branch=$(echo "$current_branch" | sed 's/\.fix$//g').bak
remote="$(git config gsync.remote)"
remote_branch="$(git config gsync.branch)"
~/loadrc/gitrc/gbrd.sh "$target_branch"
git checkout -b "$target_branch" "$remote/$remote_branch"
