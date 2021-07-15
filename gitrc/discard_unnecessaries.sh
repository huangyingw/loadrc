#!/bin/zsh
git checkout "$(~/loadrc/gitrc/get_current_branch.sh).gdio.diff"
git checkout files.proj
git checkout rsync.files
