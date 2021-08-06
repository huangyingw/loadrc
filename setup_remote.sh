#!/bin/bash

apt-get update
apt-get install -y \
    mosh \
    ssh \
    tmux \
    zsh

./deploy_configurations.sh
./swith-2-zsh.sh
