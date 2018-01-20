#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

if [ $OS == "Darwin" ]
then
    exit 0
fi

apt-get update
apt-get upgrade -y
apt-get install -y \
    bcmwl-kernel-source \
    binutils \
    cryptsetup \
    curl \
    dkms \
    git \
    htop \
    kdiff3 \
    mdadm \
    mosh \
    net-tools \
    pm-utils \
    realpath  \
    slurm \
    software-properties-common \
    ssh \
    sshfs \
    tmux \
    vim-gnome
modprobe wl
cp -fv ./etc/NetworkManager/system-connections/dd-wrt /etc/NetworkManager/system-connections/dd-wrt
cp -fv ./etc/crypttab /etc/crypttab
cp -fv ./etc/mdadm/mdadm.conf /etc/mdadm/mdadm.conf
cp -fv ./etc/sudoers /etc/sudoers
update-initramfs -u
