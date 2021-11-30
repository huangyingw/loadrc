#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

sudo usermod -aG libvirt "$USER"
sudo usermod -aG kvm "$USER"
