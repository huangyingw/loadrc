#!/bin/bash

apt-get upgrade -y
apt-get purge -y totem totem-plugins
apt-get install -y \
    aptitude \
    aria2 \
    astyle \
    automake \
    autotools-dev \
    binutils \
    build-essential \
    cmake \
    coreutils \
    cryptsetup \
    curl \
    datamash \
    dialog \
    dkms \
    dos2unix \
    exuberant-ctags \
    ffmpeg \
    gdebi-core \
    git \
    git-gui \
    gparted \
    graphviz \
    hashcat \
    hfsprogs \
    htop \
    ifenslave \
    inetutils-traceroute \
    iperf \
    iperf3 \
    iputils-ping \
    jdupes \
    jq \
    kdiff3 \
    libsecret-1-dev \
    libsecret-tools \
    locales \
    manpages-pl \
    mdadm \
    moreutils \
    mplayer \
    mysql-client \
    net-tools \
    nfs-kernel-server \
    npm \
    openvpn \
    p7zip-full \
    p7zip-rar \
    parallel \
    patchutils \
    perl \
    pm-utils \
    pv \
    pwgen \
    python3-autopep8 \
    python3-software-properties \
    rarcrack \
    resolvconf \
    rsync \
    slurm \
    smplayer \
    software-properties-common \
    sshfs \
    tig \
    transmission-cli \
    transmission-common \
    transmission-daemon \
    unrar \
    w3m \
    w3m-img \
    wakeonlan \
    wget \
    xclip \
    zsh

apt-get install -y \
    manpages-fr-extra \
    netcat \
    python3-nltk


pacman -Syy && \
    pacman --noconfirm -Sy \
    cryptsetup \
    gnu-netcat

modprobe wl
update-initramfs -u
locale-gen en_US.UTF-8
