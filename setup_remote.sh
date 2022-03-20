#!/bin/bash

rw && \
    pacman --noconfirm -Syu \
    mosh \
    tmux \
    zsh

./deploy_configurations.sh
~/loadrc/bashrc/ln_fs.sh ~/loadrc/.ssh ~/.ssh
./setup_locale.sh
./swith-2-zsh.sh
