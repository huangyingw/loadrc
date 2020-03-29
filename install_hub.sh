#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

add-apt-repository  -y ppa:cpick/hub
apt-get update -y
apt-get install -y hub
