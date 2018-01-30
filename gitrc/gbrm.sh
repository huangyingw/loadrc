#!/bin/bash -
if [ -z "$1" ]
then
    echo -e "${red}please provide the new branch name... ${NC}"
    exit 1
fi

CURRENT_BRANCH=$(~/loadrc/gitrc/get_current_branch.sh)
NEW_BRANCH="$1"

git branch -m "$CURRENT_BRANCH" "$NEW_BRANCH"
