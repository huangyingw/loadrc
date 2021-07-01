#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

if [ $(uname) = "Darwin" ]
then
    exit 0
fi

apt-get update ; \
    apt-get install -y \
    bridge-utils \
    libvirt-clients \
    libvirt-daemon \
    qemu \
    qemu-kvm \
    virt-manager

./configure.sh
