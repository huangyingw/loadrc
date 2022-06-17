#!/bin/bash

apt-get update && \
    apt-get install -y \
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

./deploy_configurations.sh
~/loadrc/bashrc/ln_fs.sh ~/loadrc/.ssh ~/.ssh
./setup_locale.sh
./swith-2-zsh.sh
