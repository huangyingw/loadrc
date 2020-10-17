#!/bin/zsh
if [ -z "$1" ]
then
    echo -e "${red}Please provide tag name... ${NC}"
    exit 1
fi
if [ -z "$2" ]
then
    echo -e "${red}Please provide commit message... ${NC}"
    exit 1
fi
git tag "$1" -m "$2"
~/loadrc/gitrc/gps.sh
