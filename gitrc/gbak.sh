#!/bin/zsh
current_branch="$(~/loadrc/gitrc/get_current_branch.sh)"
target_branch=$(echo "$current_branch" | sed 's/\.fix$//g').bak
local_master="$(git config gsync.branch)"
~/loadrc/gitrc/gbrd.sh "$target_branch"
git checkout -b "$target_branch" "$local_master"
