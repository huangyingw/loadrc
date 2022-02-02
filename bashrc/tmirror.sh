#!/bin/zsh
source=$1
target=$2

ready_file="$source"/"tmirror.ready"

iconvs=$(~/loadrc/bashrc/get_iconvs.sh "$source" "$target")
rsync_basic_options=($(< ~/loadrc/bashrc/rsync_basic_options))

rsync \
    -in \
    --delete-before \
    "${rsync_basic_options[@]}" \
    "$iconvs" \
    "$source/" "$target/" > "$ready_file"
