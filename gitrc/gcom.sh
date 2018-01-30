#!/bin/bash
old_branch=$(~/loadrc/gitrc/get_current_branch.sh)
echo $old_branch
if [ -z "$(git status --porcelain)" ]
then
    git checkout "$1" \
        && ~/loadrc/gitrc/gme.sh "$old_branch"
else
    git add . \
        && git stash|grep -q "HEAD is now at" \
        && git checkout "$1" \
        && ~/loadrc/gitrc/gme.sh "$old_branch" \
        && git stash pop stash@{0} \
        && git reset HEAD .
fi
