#!/bin/zsh

if [ -z "$1" ] || [ -z "$2" ]
then
    echo -e "${red}Please provide both source and target parameters... ${NC}"
    exit 1
fi

if [[ "$2" != *":"* ]] && [[ ! -d "$2" ]]
then
    mkdir -p "$2"
fi

source="$1"
realpath "$1" && source=$(realpath "$1")

target="$2"
realpath "$2" && target=$(realpath "$2")

if [ -n "$source" ] && [ -n "$target" ] && [ "$source" != "$target" ]
then
    iconvs=$(~/loadrc/bashrc/get_iconvs.sh "$source" "$target") 
    rsync --remove-source-files -aHSv --progress --force \
        "$iconvs" "$source" "$target" ; \
        ~/loadrc/bashrc/rmEmpty.sh "$source/"
else
    echo -e "${red}same dir --> ${source} ... ${NC}"
    echo -e "${red}please choose the different dir! ... ${NC}"
    exit 1
fi
