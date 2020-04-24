#!/bin/zsh
if [ -z $(git config gsync.remote) ] || [ -z $(git config gsync.branch) ] 
then
    exit 0
fi

~/loadrc/gitrc/gpl.sh

local_branch="$(~/loadrc/gitrc/get_current_branch.sh)" 
output="$local_branch.gdio.diff"
output=$(echo "$output" | sed 's/\//_/g')
local_master="$(git config gsync.branch)"
remote="$(git config gsync.remote)"

~/loadrc/gitrc/gdi.sh "$remote/$local_master " "$local_branch" 2>&1 | tee "$output"  
sed -i.bak "s/^--- a\//--- \.\//g;s/^+++ b\//+++ \.\//g" "$output"
exit 0
