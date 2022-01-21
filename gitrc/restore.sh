#!/bin/zsh

CURRET_BRANCH_DIFF="$(~/loadrc/gitrc/get_current_branch.sh).gdio.diff"
~/loadrc/gitrc/gdio.sh
git apply --reverse "$CURRET_BRANCH_DIFF"
