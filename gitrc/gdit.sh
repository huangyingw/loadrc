#!/bin/zsh
output="$1"
current_branch="$(~/loadrc/gitrc/get_current_branch.sh)"
target_branch=$(echo "$current_branch" | sed 's/\.fix$//g')
remote="$(git config gsync.remote)"
remote_branch="$(git config gsync.branch)"
local_master="$(git config gsync.branch)"

git checkout files.proj
git checkout -b "$target_branch" "$local_master"
git checkout "$target_branch"

git pull --ff-only "$remote" "$target_branch" ; \
    git rebase "$remote/$remote_branch" && \
    git push "$remote" ; \
    git checkout "$current_branch" && \
    ~/loadrc/gitrc/gdi.sh "$target_branch " "$current_branch" 2>&1 | tee "$output"

if [ $? -ne 0 ]
then
    echo -e "${red}most probably sth wrong in git merge... ${NC}" 2>&1 | tee "$output"
    exit 1
fi
