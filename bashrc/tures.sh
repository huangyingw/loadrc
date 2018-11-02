#!/bin/bash
if [ $(uname) == "Darwin" ]
then
    echo -e "${red}It could only run in Linux... ${NC}"
    exit 1
fi

if [ -z "$1" ]
then
    echo -e "${red}Please provide SOURCE ... ${NC}"
    exit 1
fi

if [ -z "$2" ]
then
    echo -e "${red}Please provide TARGET ... ${NC}"
    exit 1
fi

rsync -aHSvn --progress --delete-before --force --exclude-from ~/loadrc/bashrc/ures_ex "$1" "$2" 2>&1 | tee tures.find_result
nvim tures.find_result
