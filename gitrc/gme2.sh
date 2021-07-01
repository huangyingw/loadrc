#!/bin/zsh
CURRENT_BRANCH=$(~/loadrc/gitrc/get_current_branch.sh)

if [ -z "$1" ]
then
    echo -e "${red}Please provide target_branch... ${NC}"
    exit 1
fi

git fetch . "$CURRENT_BRANCH":"$1"
