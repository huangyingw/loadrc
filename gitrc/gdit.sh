#!/bin/zsh
output="$1"
current_branch="$(~/loadrc/gitrc/get_current_branch.sh)"
target_branch=$(echo "$current_branch" | sed 's/\.fix$//g')
remote="$(git config gsync.remote)"
target="$(git config gsync.target)"

~/loadrc/gitrc/discard_unnecessaries.sh
git checkout "$target_branch" "$target"
git branch -u "$remote/$target_branch"
git merge -X theirs "$target" && \
    git fetch "$remote" "$ss":"$ss" ; \
    git pull && \
    ~/loadrc/gitrc/gdi.sh "$target_branch " "$current_branch" 2>&1 | tee "$output"


if [ $? -ne 0 ]
then
    echo -e "${red}most probably sth wrong in git merge... ${NC}" 2>&1 | tee "$output"
    exit 1
fi
