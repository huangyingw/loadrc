#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

if [ $(uname) != "Darwin" ]
then
    curl -s https://install.zerotier.com/ | bash
    zerotier-cli join 93afae5963560e41
else
    wget -nc https://download.zerotier.com/dist/ZeroTier%20One.pkg -P ./installer/
    sudo installer -package ./installer/ZeroTier\ One.pkg -target /
fi
