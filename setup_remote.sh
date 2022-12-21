#!/bin/bash

sudo apt-get update && \
    sudo apt-get install -y \
    mosh \
    ssh \
    tmux \
    zsh

rw ; \
    pacman -Syy && \
    pacman --noconfirm -Sy \
    mosh \
    net-tools \
    openssh \
    rsync \
    tmux \
    zsh

pacman -Syu

./deploy_configurations.sh
./setup_locale.sh
./swith-2-zsh.sh
