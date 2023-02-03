#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

if [ $(uname) = "Darwin" ]
then
    echo "it is macos"
else
    echo "it is Linux"
fi

if [ $(uname) = "Darwin" ]
then
    echo "it is macos"
else
    echo "it is Linux"
fi

if [[ $(uname) == "Darwin" ]]
then
    echo "it is macos"
else
    echo "it is Linux"
fi
