#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

find host_links/`hostname`/ -type f | while read ss; \
do \
    sudo ~/loadrc/bashrc/ln_fs.sh "$ss" "/$(echo "$ss" | sed "s/hosts\/`hostname`\///g")"; \
done

HOSTTODOS=~/loadrc/hosts/"`hostname`/todos.sh"
if [ -f "$HOSTTODOS" ]
then
    "$HOSTTODOS"
fi

~/loadrc/zerotierrc/restart.sh
