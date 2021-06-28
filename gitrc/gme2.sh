#!/bin/zsh

if [ -z "$1" ]
then
    echo -e "${red}Please provide target_branch... ${NC}"
    exit 1
fi

CURRENT_BRANCH=$(~/loadrc/gitrc/get_current_branch.sh)
git fetch . "$CURRENT_BRANCH":"$1"
