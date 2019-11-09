#!/bin/bash -
local_branch="$1"
output="$2"
local_master="$(git config gsync.branch)"

~/loadrc/gitrc/gsync.sh
~/loadrc/gitrc/gdi.sh "$local_master " "$local_branch" 2>&1 | tee "$output"  
