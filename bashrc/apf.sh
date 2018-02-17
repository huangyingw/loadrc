#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

if [ $(uname) != "Darwin" ]
then
    /usr/NX/scripts/setup/nxserver --update debian
    apt-get update && aptitude -y full-upgrade
else
    brew update ; brew upgrade
fi
