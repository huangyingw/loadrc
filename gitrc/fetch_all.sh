#!/bin/zsh
~/loadrc/gitrc/include_gitconfig.sh
git branch | grep -v ^* | while read ss; \
do \
    git fetch origin "$ss":"$ss" ; \
done
