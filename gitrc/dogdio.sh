#!/bin/zsh

if [ -z $(git config gsync.target) ]
then
    exit 0
fi

local_branch="$(~/loadrc/gitrc/get_current_branch.sh)"
output="$local_branch.gdio.diff"
output=$(echo "$output" | sed 's/\//_/g')
target="$(git config gsync.target)"

~/loadrc/gitrc/gdi.sh "$target" 2>&1 | tee "$output"
