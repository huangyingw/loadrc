#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

apt-get update
apt-get upgrade -y
apt-get install -y \
    binutils \
    bridge-utils \
    build-essential \
    curl \
    g++ make \
    gcc \
    git \
    kdiff3 \
    libvirt-bin \
    mosh \
    net-tools \
    qemu-kvm \
    software-properties-common \
    ssh \
    sshfs \
    tmux \
    ubuntu-vm-builder \
    vim-gnome
