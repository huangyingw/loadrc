#!/bin/bash -
local_branch="$1"
output="$2"
branch="$(git config gsync.branch)"

~/loadrc/gitrc/gsync.sh
~/loadrc/gitrc/gdi.sh "$branch " "$local_branch" 2>&1 | tee "$output"  
