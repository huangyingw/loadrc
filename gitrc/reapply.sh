#!/bin/zsh
DIFF="$1"
CURRET_BRANCH_DIFF="$(~/loadrc/gitrc/get_current_branch.sh).gdio.diff"
git show HEAD:"$CURRET_BRANCH_DIFF" > "$CURRET_BRANCH_DIFF".bak
git apply --reverse "$CURRET_BRANCH_DIFF".bak
git apply --reject --whitespace=fix "$DIFF"
~/loadrc/gitrc/gdio.sh

if [ "$CURRET_BRANCH_DIFF" = "$DIFF" ]
then
    git add "$CURRET_BRANCH_DIFF"
fi
