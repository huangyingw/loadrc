#!/bin/zsh
SOURCE=$1
TARGET=$2

ready_file="$SOURCE"/"tmirror.ready"

if [ ! -d "$TARGET" ]
then
    mkdir -p "$TARGET"
fi

rsync -aHinv --delete-before --force \
    "$SOURCE" "$TARGET" > "$ready_file"
