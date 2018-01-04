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
    cryptsetup \
    curl \
    g++ make \
    gcc \
    git \
    kdiff3 \
    libvirt-bin \
    mldonkey-server \
    mosh \
    net-tools \
    python-dev \
    python-pip \
    qemu-kvm \
    software-properties-common \
    ssh \
    sshfs \
    tmux \
    ubuntu-vm-builder \
    vim-gnome
pip install --upgrade pip
pip install --upgrade virtualenv
