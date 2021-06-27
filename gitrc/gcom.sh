#!/bin/zsh

if [ -z "$1" ]
then
    echo -e "${red}Please provide target_branch... ${NC}"
    exit 1
fi

git checkout -b "$1" || \
    ~/loadrc/gitrc/gme2.sh "$1" && \
    git checkout "$1"
