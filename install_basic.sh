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
        astyle \
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
        gparted \
        htop \
        kdiff3 \
        manpages-fr-extra \
        manpages-pl \
        mdadm \
        mosh \
        mplayer \
        net-tools \
        pm-utils \
        pv \
        python-autopep8 \
        resolvconf \
        slurm \
        smplayer \
        ssh \
        sshfs \
        tmux \
        vim-gnome \
        w3m \
        w3m-img \
        wakeonlan
    modprobe wl
    update-initramfs -u
else
    brew install \
        blueutil \
        coreutils
    brew cask install kdiff3
    brew link --overwrite neovim
fi

./nxrc/install.sh
./enpass_install.sh
./chrome_install.sh
./zerotierrc/zerotier_install.sh
./deploy_configurations.sh
