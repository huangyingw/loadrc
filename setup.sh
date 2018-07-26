#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

~/loadrc/gitrc/gpl.sh
./install_basic.sh
./submodule_setup.sh
./vimrc/.vim/bundle/vim-ghost/install.sh
./kvmrc/install.sh
./dockerrc/install.sh
./post_setup.sh
