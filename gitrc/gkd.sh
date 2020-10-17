#!/bin/zsh
if [ -n "$1" ]
then
    if [ -n "$2" ]
    then
        git difftool -t kdiff3 -y "$1" "$2"
    else
        COMMAND="git difftool -t kdiff3 -y $1"

        for ss in $(git config --get-all gdif.ignore)
        do
            COMMAND="$COMMAND  ':(exclude)$ss'"
        done

        eval "$COMMAND"
    fi
else
    git difftool -t kdiff3 -y --cached
fi
