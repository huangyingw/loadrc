#!/bin/zsh

if [ -z "$1" ]
then
    echo -e "${red}Please provide the relative path to file ... ${NC}"
    exit 1
fi

# this is used to reset back to the latest change on the file.
commit=`git rev-list --branches -n 1 HEAD -- "$1"`
git show "$commit"^:"$1" > "$1"
