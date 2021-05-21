#!/bin/zsh
output="$1"
current_branch="$(~/loadrc/gitrc/get_current_branch.sh)"
target_branch=$(echo "$current_branch" | sed 's/\.fix$//g')
remote="$(git config gsync.remote)"
remote_branch="$(git config gsync.branch)"

~/loadrc/gitrc/discard_unnecessaries.sh
git checkout -b "$target_branch" "$remote/$target_branch"
git checkout -b "$target_branch" "$remote/$remote_branch"
git checkout -f "$target_branch"
git branch -u "$remote/$target_branch"
git merge -X theirs "$remote/$remote_branch" && \
    git pull && \
    git push ; \
    git checkout "$current_branch" && \
    ~/loadrc/gitrc/gdi.sh "$target_branch " "$current_branch" 2>&1 | tee "$output"
    dos2unix "$output" 

if [ $? -ne 0 ]
then
    echo -e "${red}most probably sth wrong in git merge... ${NC}" 2>&1 | tee "$output"
    exit 1
fi
