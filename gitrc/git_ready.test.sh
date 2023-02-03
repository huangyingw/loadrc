#!/bin/zsh

if [ $(~/loadrc/gitrc/git_ready.sh) ]
then
    echo true
else
    echo false
fi
