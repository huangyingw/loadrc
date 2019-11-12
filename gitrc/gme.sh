#!/bin/bash
~/loadrc/gitrc/include_gitconfig.sh
if [ "$(git config merge.allow)" != "true" ]
then
    echo -e "${red}git merge is not allowed, without git config merge.allow is true ... ${NC}"
    exit 1
fi
git merge "$1" \
    && ~/loadrc/gitrc/gps.sh
