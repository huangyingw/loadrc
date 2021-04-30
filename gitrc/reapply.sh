#!/bin/zsh
DIFF="$1"
git apply --reverse "$(~/loadrc/gitrc/get_current_branch.sh).gdio.diff" 
git checkout -- "$DIFF"
git apply --reject --whitespace=fix "$DIFF"
~/loadrc/gitrc/gdio.sh
git add "$DIFF"
