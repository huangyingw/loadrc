#!/bin/zsh
DIFF="$1"
CURRET_BRANCH_DIFF="$(~/loadrc/gitrc/get_current_branch.sh).gdio.diff"
git apply --reverse "$CURRET_BRANCH_DIFF" 
git checkout -- "$CURRET_BRANCH_DIFF"
git apply --reject --whitespace=fix "$DIFF"
~/loadrc/gitrc/gdio.sh
git add "$CURRET_BRANCH_DIFF"
