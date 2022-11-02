#!/bin/zsh

if [ -z "$1" ] || [ -z "$2" ]
then
    echo -e "${red}Please provide both source and target parameters... ${NC}"
    exit 1
fi

source=$1
target=$2

iconvs=$(~/loadrc/bashrc/get_iconvs.sh "$source" "$target")
rsyncpath=$(~/loadrc/bashrc/get_rsyncpath.sh "$source" "$target")
rsync_basic_options=($(< ~/loadrc/bashrc/rsync_basic_options))

rsync \
    "${rsync_basic_options[@]}" \
    "$iconvs" \
    "$rsyncpath" \
    "$source/" "$target/"
