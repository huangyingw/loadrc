#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

apt-add-repository ppa:cubic-wizard/release
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B7579F80E494ED3406A59DF9081525E2B4F1283B
apt update
apt install -y cubic
