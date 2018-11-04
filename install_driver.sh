#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

cp -fv ./etc/modprobe.d/blacklist.conf /etc/modprobe.d/blacklist.conf
add-apt-repository ppa:graphics-drivers/ppa -y
apt-get update
apt-get -y install $(ubuntu-drivers devices|awk '/recommended/{print $3}')
