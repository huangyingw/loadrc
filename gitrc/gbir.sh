#!/bin/zsh

if [ ! -f gbil.log ]
then
    echo -e "${red}Must run with gbil.log file... ${NC}"
    exit 1
fi
git bisect replay gbil.log \
    && git bisect log | tee gbil.log
