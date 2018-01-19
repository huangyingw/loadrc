#!/bin/bash
CURRENT_BRANCH="`git branch |awk '/^\*/{print $2}'`"
if [ -z "$1" ]
then
    echo -e "${red}Please provide target_branch... ${NC}"
    exit 1
fi

TARGET_BRANCH="$1"
echo "$TARGET_BRANCH"

if [ -z "$(git status --porcelain)" ]
then
    git checkout "$TARGET_BRANCH" \
        && ~/loadrc/gitrc/gme.sh "$CURRENT_BRANCH" \
        ; git checkout "$CURRENT_BRANCH"
else
    git add . \
        && git stash|grep -q "HEAD is now at" \
        && git checkout "$TARGET_BRANCH" \
        && ~/loadrc/gitrc/gme.sh "$CURRENT_BRANCH" \
        ; git checkout "$CURRENT_BRANCH" \
        && git stash pop stash@{0} \
        && git reset HEAD .
fi
