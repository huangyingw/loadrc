#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

add-apt-repository -y ppa:flacon
apt-get update
apt-get install -y flacon
