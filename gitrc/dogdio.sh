#!/bin/zsh
if [ -z $(git config gsync.remote) ] || [ -z $(git config gsync.branch) ] 
then
    exit 0
fi

local_branch="$(~/loadrc/gitrc/get_current_branch.sh)" 
output="$local_branch.gdio.diff"
output=$(echo "$output" | sed 's/\//_/g')
remote_branch="$(git config gsync.branch)"
remote="$(git config gsync.remote)"

~/loadrc/gitrc/gdi.sh "$remote/$remote_branch" 2>&1 | tee "$output"  
sed -i.bak "s/^--- a\//--- \.\//g;s/^+++ b\//+++ \.\//g" "$output"
dos2unix "$output"
exit 0
