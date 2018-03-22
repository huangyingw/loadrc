#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

deploy_configs() {
    TARGET="$1"
    SOURCE=~/loadrc/"$TARGET"
    if [ -f "$SOURCE" ]
    then
        cp -fv "$SOURCE" "$TARGET"
    fi
}

while read -r line || [[ -n "$line" ]]
do
    deploy_configs "$line"
done < linux.conf
