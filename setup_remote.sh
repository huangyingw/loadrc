#!/bin/bash

apt-get update
apt-get install -y \
    ssh \
    tmux \
    vim \
    zsh

apt-get install -y mosh

./deploy_configurations.sh
~/loadrc/bashrc/ln_fs.sh ~/loadrc/.ssh ~/.ssh
./swith-2-zsh.sh
