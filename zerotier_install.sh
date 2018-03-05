#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

if [ $(uname) == "Darwin" ]
then
    exit 0
fi

curl -s https://install.zerotier.com/ | bash
zerotier-cli join 93afae5963560e41
