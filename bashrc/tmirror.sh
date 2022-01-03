#!/bin/zsh
source=$1
target=$2

ready_file="$source"/"tmirror.ready"

if [ ! -d "$target" ]
then
    mkdir -p "$target"
fi

iconvs=$(~/loadrc/bashrc/get_iconvs.sh "$source" "$target")

COMMAND="rsync -aHivn --delete-before --force"
COMMAND="$COMMAND $iconvs $source/ $target/ > $ready_file"
eval "$COMMAND"
