#!/bin/zsh

output="$1"
current_branch="$(~/loadrc/gitrc/get_current_branch.sh)"
target_branch=$(echo "$current_branch" | sed 's/\.fix$//g')
remote="$(git config gsync.remote)"
target="$(git config gsync.target)"

git branch "$target_branch" "$target"

# Switch to the target branch
~/loadrc/gitrc/gco.sh "$target_branch"

# Update all branches from all remotes
git remote update

# Merge the first branch
~/loadrc/gitrc/merge_with_resolution.sh "$remote/$target_branch"

# Merge the second branch
remote_branch=$(echo "$target" | sed "s/^$remote\///g")
~/loadrc/gitrc/merge_with_resolution.sh "$remote/$remote_branch"

# Switch back to the current branch
~/loadrc/gitrc/gco.sh "$current_branch"

~/loadrc/gitrc/gdi.sh "$target_branch " "$current_branch" "gdit" > "$output" 2>&1

if [ $? -ne 0 ]
then
    echo -e "${red}most probably something went wrong in git merge... ${NC}" > "$output" 2>&1
    exit 1
fi

remote="$(git config gdi2.remote)"
git push "$remote" "$target_branch"
