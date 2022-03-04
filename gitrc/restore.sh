#!/bin/zsh

CURRET_BRANCH_DIFF="$(~/loadrc/gitrc/get_current_branch.sh).gdio.diff"
~/loadrc/gitrc/gdio.sh
git apply --reject --whitespace=fix --recount --reverse "$CURRET_BRANCH_DIFF" || \
    echo "git reverse apply failed" && \
    exit 1
