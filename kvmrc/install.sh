#!/bin/bash -

if [ $OS == "Darwin" ]
then
    exit 0
fi

apt-get install -y \
    bcmwl-kernel-source \
    binutils \
    bridge-utils \
    build-essential \
    cpu-checker \
    cryptsetup \
    curl \
    dkms \
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
    qemu-kvm \
    slurm \
    software-properties-common \
    ssh \
    sshfs \
    tmux \
    ubuntu-vm-builder \
    vim-gnome \
    virt-manager \
    virtinst \
    virt-manager
