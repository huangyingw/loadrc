#!/bin/zsh
local_branch="$1"
output="$2"
local_master="$(git config gsync.branch)"
remote="$(git config gsync.remote)"

~/loadrc/gitrc/gsync.sh
~/loadrc/gitrc/gdi.sh "$remote/$local_master " "$local_branch" 2>&1 | tee "$output"  
