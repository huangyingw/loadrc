#!/bin/zsh

output="$1"
current_branch="$(~/loadrc/gitrc/get_current_branch.sh)"
target_branch=$(echo "$current_branch" | sed 's/\.fix$//g')
remote="$(git config gsync.remote)"
target="$(git config gsync.target)"

git branch "$target_branch" "$target"
git fetch "$remote" "$target_branch":"$target_branch"
remote_branch=$(echo "$target" | sed "s/^$remote\///g")
git fetch "$remote" "$remote_branch":"$target_branch"

~/loadrc/gitrc/gdi.sh "$target_branch " "$current_branch" "gdit" > "$output" 2>&1

if [ $? -ne 0 ]
then
    echo -e "${red}most probably sth wrong in git merge... ${NC}" > "$output" 2>&1
    exit 1
fi

remote="$(git config gdi2.remote)"
git push "$remote" "$target_branch"
