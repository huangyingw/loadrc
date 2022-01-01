#!/bin/zsh
source=$1
target=$2

ready_file="$source"/"tmirror.ready"

if [ ! -d "$target" ]
then
    mkdir -p "$target"
fi

iconvs=$(~/loadrc/bashrc/get_iconvs.sh "$source" "$target") 

rsync -aHivn --delete-before --force \
    "$iconvs" "$source" "$target" > "$ready_file"
