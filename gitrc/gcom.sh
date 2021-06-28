#!/bin/zsh

if [ -z "$1" ]
then
    echo -e "${red}Please provide target_branch... ${NC}"
    exit 1
fi

CURRENT_BRANCH=$(~/loadrc/gitrc/get_current_branch.sh)
git checkout -b "$1" || \
    git checkout "$1" &&
    git merge "$CURRENT_BRANCH"
