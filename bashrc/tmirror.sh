#!/bin/zsh
source=$1
target=$2

ready_file="$source"/"tmirror.ready"

if [ ! -d "$target" ]
then
    mkdir -p "$target"
fi

siconv=$(~/loadrc/bashrc/get_iconv.sh "$source")
ticonv=$(~/loadrc/bashrc/get_iconv.sh "$target")

rsync -aHinv --delete-before --force \
    --iconv="$siconv,$ticonv" \
    "$source" "$target" > "$ready_file"
