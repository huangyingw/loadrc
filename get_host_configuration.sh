#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

get_configs() {
    SOURCE="$1"
    TARGET=~/loadrc/"`hostname`$SOURCE"
    mkdir -p "$(dirname $TARGET)"
    cp -v "$SOURCE" "$TARGET"
}

while read -r line || [[ -n "$line" ]]
do
    get_configs "$line"
done < host.conf
