#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

if [ $(uname) != "Linux" ]
then
    exit 0
fi

deploy_configs() {
    TARGET="$1"
    SOURCE=~/loadrc/"$TARGET"
    if [ -f "$SOURCE" ]
    then
        cp -nv "$TARGET" "$TARGET".bak
        ln -fs "$SOURCE" "$TARGET"
    fi
}

while read -r line || [ -n "$line" ]
do
    deploy_configs "$line"
done < linux.conf
