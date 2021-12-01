#!/bin/bash

apt-get update
apt-get install -y \
    mosh \
    ssh \
    tmux \
    zsh

./deploy_configurations.sh
~/loadrc/bashrc/ln_fs.sh ~/loadrc/.ssh ~/.ssh
./swith-2-zsh.sh
