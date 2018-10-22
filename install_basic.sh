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
        automake \
        autotools-dev \
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
        manpages-fr-extra \
        manpages-pl \
        mdadm \
        mosh \
        mplayer \
        net-tools \
        pm-utils \
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
        coreutils
    brew link --overwrite neovim
fi

./nxrc/install.sh
./zerotierrc/zerotier_install.sh
./deploy_configurations.sh
