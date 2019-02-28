#!/bin/bash - 

if [ $(hostname) != "lint-sandbox" ]
then
    echo -e "${red}Please only run in imvu lint-sandbox ... ${NC}"  
    exit 1
fi

~/loadrc/gitrc/grsh.sh
~/loadrc/gitrc/gclean.sh
git co master
git remote update
git branch -D "$1"
git co -b "$1" origin/"$1"
s/hypo
