#!/bin/bash
if [ ${PWD##*/} == ".git" ]
then
    cd ../
fi

if [ -n "$1" ];
then
    if [ -n "$2" ];
    then
        git difftool "$1" "$2"
    else
        git difftool "$1"
    fi
else
    git difftool --cached
    git difftool
fi
