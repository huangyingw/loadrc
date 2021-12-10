#!/bin/zsh

if [ -n "$(git status --untracked-files=no --porcelain --ignore-submodules)" ]
then
    echo -e "${red}the git repository is unclean, please check it before continuing... ${NC}"
    exit 1
fi
