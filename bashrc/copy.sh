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
rsync_basic_options=($(< ~/loadrc/bashrc/rsync_basic_options))       # might be problematic if dealing with embedded white space
# mapfile -t rsync_basic_options < rsync_basic_options

rsync \
    "${rsync_basic_options[@]}" \
    "$iconvs" \
    "$source/" "$target/"
