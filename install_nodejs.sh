#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
apt install -y nodejs
