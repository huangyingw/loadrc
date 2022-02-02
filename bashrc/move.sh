#!/bin/zsh

if [ -z "$1" ] || [ -z "$2" ]
then
    echo -e "${red}Please provide both source and target parameters... ${NC}"
    exit 1
fi

source="$1"
realpath "$1" && source=$(realpath "$1")

target="$2"
realpath "$2" && target=$(realpath "$2")

if [ -n "$source" ] && [ -n "$target" ] && [ "$source" != "$target" ]
then
    iconvs=$(~/loadrc/bashrc/get_iconvs.sh "$source" "$target")
    rsync_basic_options=($(< ~/loadrc/bashrc/rsync_basic_options))
    rsync \
        --remove-source-files \
        "${rsync_basic_options[@]}" \
        "$iconvs" \
        "$source/" "$target/" ; \
        ~/loadrc/bashrc/rmEmpty.sh "$source"

else
    echo -e "${red}same dir --> ${source} ... ${NC}"
    echo -e "${red}please choose the different dir! ... ${NC}"
    exit 1
fi
