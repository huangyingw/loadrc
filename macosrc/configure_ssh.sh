#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

sudo cp -nv /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
sudo cp -fv ./etc/ssh/sshd_config /etc/ssh/sshd_config
