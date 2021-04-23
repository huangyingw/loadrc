#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

find host_links/`hostname`/ -type f | while read ss; \
do \
    ~/loadrc/bashrc/ln_fs.sh "$ss" "/$(echo "$ss" | sed "s/host_links\/`hostname`\///g")"; \
done

find hosts/`hostname`/ -type f | while read ss; \
do \
    sudo cp -fv "$ss" "/$(echo "$ss" | sed "s/hosts\/`hostname`\///g")"; \
done

HOSTTODOS=~/loadrc/host_links/"`hostname`/todos.sh"
if [ -f "$HOSTTODOS" ]
then
    "$HOSTTODOS"
fi
