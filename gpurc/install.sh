#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

if [ "$OS" == "Darwin" ]
then
    return
fi

. ./install_driver.sh
. ./install_nvidia-reload.sh
