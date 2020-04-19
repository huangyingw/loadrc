#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

if [ $(uname) = "Darwin" ]
then
    exit 0
fi

apt-get install -y \
    bridge-utils \
    build-essential \
    cpu-checker \
    g++ make \
    gcc \
    git \
    htop \
    kdiff3 \
    libvirt-bin \
    mdadm \
    mosh \
    net-tools \
    pm-utils \
    python-dev \
    python-pip \
    qemu \
    qemu-kvm \
    slurm \
    software-properties-common \
    ssh \
    sshfs \
    tmux \
    ubuntu-vm-builder \
    vim-gnome \
    virt-manager \
    virtinst

./configure.sh
