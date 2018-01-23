#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

if [ $(uname) == "Darwin" ]
then
    . ./macvim/build.sh
else
    . /etc/lsb-release
    cd ./pkg-vim/
    git co "$DISTRIB_CODENAME" \
        && ./build.sh
    cd -
fi
