#!/bin/zsh
if [ -z "$1" ] || [ -z "$2" ]
then
    echo -e "${red}Please provide both source and target vm name ... ${NC}"
    exit 1
fi

virt-clone --original "$1" --auto-clone --name "$2"
