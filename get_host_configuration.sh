#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

get_configs() {
    SOURCE="$1"
    TARGET=~/loadrc/"`hostname`$SOURCE"
    DIR=$(dirname "$TARGET")
    mkdir -p "$DIR"
    sudo cp -v "$SOURCE" "$DIR"
}

while read -r line || [[ -n "$line" ]]
do
    get_configs "$line"
done < host.conf
