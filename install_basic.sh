#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

apt-get update
apt-get upgrade -y
apt-get install -y \
    bcmwl-kernel-source \
    binutils \
    bridge-utils \
    build-essential \
    cryptsetup \
    curl \
    dkms \
    g++ make \
    gcc \
    git \
    kdiff3 \
    libvirt-bin \
    mdadm \
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
    vim-gnome \
    virt-manager
modprobe wl
pip install --upgrade pip
pip install --upgrade virtualenv
cp -fv ./etc/NetworkManager/system-connections/dd-wrt /etc/NetworkManager/system-connections/dd-wrt
cp -fv ./etc/crypttab /etc/crypttab
cp -fv ./etc/mdadm/mdadm.conf /etc/mdadm/mdadm.conf
update-initramfs -u
