#!/bin/zsh
if [ -z $(git config gsync.remote) ] || [ -z $(git config gsync.branch) ] 
then
    exit 0
fi

local_branch="$(~/loadrc/gitrc/get_current_branch.sh)" 
output="$local_branch.gdio.diff"
local_master="$(git config gsync.branch)"
remote="$(git config gsync.remote)"

~/loadrc/gitrc/gsync.sh
~/loadrc/gitrc/gdi.sh "$remote/$local_master " "$local_branch" 2>&1 | tee "$output"  
