#!/bin/bash

apt-get upgrade -y
apt-get purge -y totem totem-plugins
apt-get install -y \
    aptitude \
    aria2 \
    astyle \
    automake \
    autotools-dev \
    bcache-tools \
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
    golang-go \
    gparted \
    graphviz \
    hashcat \
    hfsprogs \
    htop \
    ifenslave \
    inetutils-traceroute \
    iotop \
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
    nvidia-docker2 \
    python3-nltk


# 检查 pacman 是否存在
if command -v pacman &> /dev/null; then
    pacman -Syy && \
        pacman --noconfirm -Sy \
        cryptsetup \
        gnu-netcat
else
    echo "pacman 命令不存在，跳过 pacman 相关安装"
fi

# 检查 modprobe 是否存在
if command -v modprobe &> /dev/null; then
    modprobe wl
else
    echo "modprobe 命令不存在，跳过 modprobe 操作"
fi

# 检查 update-initramfs 是否存在
if command -v update-initramfs &> /dev/null; then
    update-initramfs -u
else
    echo "update-initramfs 命令不存在，跳过 update-initramfs 操作"
fi

# 检查 locale-gen 是否存在
if command -v locale-gen &> /dev/null; then
    locale-gen en_US.UTF-8
else
    echo "locale-gen 命令不存在，跳过 locale-gen 操作"
fi
