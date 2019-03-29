#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

find hosts/`hostname`/ -type f | while read ss; \
do \
    sudo cp -fv "$ss" "/$(echo "$ss" | sed "s/hosts\/`hostname`\///g")"; \
done

HOSTTODOS=~/loadrc/hosts/"`hostname`/todos.sh"
if [ -f "$HOSTTODOS" ]
then
    "$HOSTTODOS"
fi

~/loadrc/zerotierrc/zerotier_restart.sh
