#!/bin/zsh
if [ -n "$(git status --porcelain)" ]
then
    echo -e "${red}the git repository is unclean, please check it before continuing... ${NC}"
    exit 1
fi
