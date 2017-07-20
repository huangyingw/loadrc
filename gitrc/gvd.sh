#!/bin/bash
if [ -n "$1" ];
then
    if [ -n "$2" ];
    then
        git difftool -y "$1" "$2"
    else
        git difftool -y "$1"
    fi
else
    git difftool -y --cached
    git difftool -y
fi
