#!/bin/zsh
if [ -z "$1" ]
then
    projectFile=$(~/loadrc/bashrc/find_up.sh $PWD files.proj)

    if [ -z "$projectFile" ]
    then
        nvim ~/all.proj
    else
        nvim "$projectFile"
    fi
else
    nvim "$1"
fi
