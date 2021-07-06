#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

. ~/.zshrc
nvm install node
OTHER_NODE="/usr/local/bin/node"

if [ -f "$OTHER_NODE" ]
then
    mv -v "$OTHER_NODE" "$OTHER_NODE".bak
fi
