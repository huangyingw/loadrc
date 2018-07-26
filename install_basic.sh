#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

if [ $(uname) != "Darwin" ]
then
    apt-get update
    apt-get upgrade -y
    apt-get purge -y totem totem-plugins
    apt-get install -y \
        aptitude \
        bcmwl-kernel-source \
        binutils \
        build-essential \
        cmake \
        cryptsetup \
        curl \
        dkms \
        exuberant-ctags \
        git \
        htop \
        kdiff3 \
        mdadm \
        mosh \
        net-tools \
        pm-utils \
        python-dev \
        python-pip \
        resolvconf \
        slurm \
        smplayer \
        ssh \
        sshfs \
        tmux \
        vim-gnome \
        wakeonlan
    modprobe wl
    update-initramfs -u
else
    brew install \
        coreutils \
        neovim
    brew link --overwrite neovim
fi

./nxrc/install.sh
./zerotier_install.sh
./deploy_configurations.sh
