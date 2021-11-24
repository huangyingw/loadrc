#!/bin/zsh
DIFF="$1"
CURRET_BRANCH_DIFF="$(~/loadrc/gitrc/get_current_branch.sh).gdio.diff"
git apply --index --reverse "$CURRET_BRANCH_DIFF"
git checkout -- "$CURRET_BRANCH_DIFF"
git apply --index --reject --whitespace=fix "$DIFF"
~/loadrc/gitrc/gdio.sh

if [ "$CURRET_BRANCH_DIFF" = "$DIFF" ]
then
    git add "$CURRET_BRANCH_DIFF"
fi
