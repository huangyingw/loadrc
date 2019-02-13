#!/bin/bash -

apt-get update
apt-get install -y \
    build-essential \
    coreutils \
    cscope \
    curl \
    gdebi-core \
    git \
    inetutils-traceroute \
    iputils-ping \
    locales \
    manpages-pl \
    netcat \
    perl \
    pwgen \
    python3-software-properties \
    rsync \
    software-properties-common \
    ssh \
    vim-gnome \
    wget
locale-gen en_US.UTF-8
