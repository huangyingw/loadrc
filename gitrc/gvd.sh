#!/bin/bash
if [ -n "$1" ]
then
    if [ -n "$2" ]
    then
        git difftool -y "$1" "$2"
    else
        git difftool -y HEAD "$1"
    fi
else
    git difftool -y --cached
fi
