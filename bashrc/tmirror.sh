#!/bin/zsh
SOURCE=$1
TARGET=$2

ready_file="$TARGET"/"tmirror.ready"
if [ ! -d "$TARGET" ]
then
    mkdir -p "$TARGET"
fi

rsync -aHinv --delete-before --force \
    "$SOURCE" "$TARGET" > "$ready_file"
cp -fv "$ready_file" ~/loadrc/tmirror.ready
nvim ~/loadrc/tmirror.ready 
