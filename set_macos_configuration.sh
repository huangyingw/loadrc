#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

if [ $(uname) != "Darwin" ]
then
    exit 0
fi

find macos_links/ -type f | while read ss; \
do \
    ~/loadrc/bashrc/ln_fs.sh "$ss" "/$(echo "$ss" | sed "s/macos_links\///g")"; \
done

find macos/ -type f | while read ss; \
do \
    sudo cp -fv "$ss" "/$(echo "$ss" | sed "s/macos\///g")"; \
done

./macosrc/configure_mosh.sh
# ./macosrc/configure_ssh.sh
