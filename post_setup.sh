#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

if [ $OS == "Darwin" ]
then
    ./bashrc/cscope.sh
fi
./gitrc/gclean.sh
