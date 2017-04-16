#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

OS=`uname`
if [ $OS != "Darwin" ];
then
    apt-get update && aptitude -y full-upgrade
else
    brew update ; brew upgrade
fi

cd -
