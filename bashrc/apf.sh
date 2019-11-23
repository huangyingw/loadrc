#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

if [ $(uname) != "Darwin" ]
then
    apt-get update
    aptitude -y full-upgrade
else
    brew update
    brew upgrade
fi
