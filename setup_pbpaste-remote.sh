#!/bin/zsh
SCRIPT=$(realpath "$0") && \
    SCRIPTPATH=$(dirname "$SCRIPT") && \
    cd "$SCRIPTPATH" || cd ~/loadrc/

mkdir -p ~/bin/

if [ -f ~/bin/pbpaste-remote ]
then
    exit 0
fi

cp -fv ./pbpaste-remote ~/bin/pbpaste-remote
