#!/bin/zsh

if [ -z "$1" ] || [ -z "$2" ]
then
    echo -e "${red}Please provide both source and target parameters... ${NC}"
    exit 1
fi

source=$1
target=$2

if [[ "$target" != *":"* ]] && [[ ! -d "$target" ]]
then
    mkdir -p "$target"
fi

iconvs=$(~/loadrc/bashrc/get_iconvs.sh "$source" "$target")
. ~/loadrc/bashrc/rsync_basic_option.sh

rsync \
    "${rsync_basic_option[@]}" \
    "$iconvs" \
    "$source/" "$target/"
