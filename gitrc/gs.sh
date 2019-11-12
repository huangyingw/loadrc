#!/bin/zsh
if [ -n "$1" ]
then
    git status "$1" 2>&1 | tee gs.findresult
else
    git status 2>&1 | tee gs.findresult
fi
