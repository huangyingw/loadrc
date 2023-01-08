#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

if [ $(uname) != "Darwin" ]
then
    curl -s https://install.zerotier.com/ | bash
    pacman --noconfirm -Sy zerotier-one
    zerotier-cli join 93afae5963560e41
fi
