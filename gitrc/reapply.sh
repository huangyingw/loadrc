#!/bin/zsh
DIFF="$1"
CURRET_BRANCH_DIFF="$(~/loadrc/gitrc/get_current_branch.sh).gdio.diff"

cp -fv "$DIFF" "$DIFF".bak
~/loadrc/gitrc/gdio.sh
git apply --reverse "$CURRET_BRANCH_DIFF"
cp -fv "$DIFF".bak "$DIFF"

git apply --reject --whitespace=fix "$DIFF"
