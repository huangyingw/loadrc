#!/bin/bash

apt-get update
apt-get upgrade -y
apt-get purge -y totem totem-plugins
apt-get install -y \
    aptitude \
    astyle \
    automake \
    autotools-dev \
    binutils \
    build-essential \
    cmake \
    coreutils \
    cryptsetup \
    cscope \
    curl \
    dkms \
    dos2unix \
    exuberant-ctags \
    ffmpeg \
    gdebi-core \
    git \
    git-gui \
    gparted \
    hfsprogs \
    htop \
    inetutils-traceroute \
    iperf \
    iperf3 \
    iputils-ping \
    kdiff3 \
    libsecret-1-dev \
    libsecret-tools \
    locales \
    manpages-fr-extra \
    manpages-pl \
    mdadm \
    mosh \
    mplayer \
    net-tools \
    netcat \
    nfs-kernel-server \
    npm \
    openvpn \
    perl \
    pm-utils \
    pv \
    pwgen \
    python3-autopep8 \
    python3-software-properties \
    resolvconf \
    rsync \
    slurm \
    smplayer \
    software-properties-common \
    ssh \
    sshfs \
    tig \
    tmux \
    unrar \
    w3m \
    w3m-img \
    wakeonlan \
    wget \
    zsh

modprobe wl
update-initramfs -u
locale-gen en_US.UTF-8

./install_hub.sh
