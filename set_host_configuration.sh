#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

deploy_configs() {
    TARGET="$1"
    SOURCE=~/loadrc/"`hostname`$TARGET"

    if [ -f "$SOURCE" ]
    then
        sudo cp -fv "$SOURCE" "$TARGET"
    fi
}

while read -r line || [[ -n "$line" ]]
do
    deploy_configs "$line"
done < host.conf

HOSTTODOS=~/loadrc/"`hostname`/todos.sh"
if [ -f "$HOSTTODOS" ]
then
    "$HOSTTODOS"
fi

~/loadrc/zerotierrc/zerotier_restart.sh
