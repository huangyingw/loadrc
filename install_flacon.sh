#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

sudo add-apt-repository -y ppa:flacon
sudo apt-get update
sudo apt-get install -y flacon
