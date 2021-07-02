#!/bin/zsh
local_branch="$(~/loadrc/gitrc/get_current_branch.sh)"
git checkout \
    "$local_branch.gdio.diff" \
    files.proj \
    rsync.files
