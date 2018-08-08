#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

~/loadrc/gitrc/gpl.sh
./install_basic.sh
./install_nvim.sh
./cscope-15.9/build.sh
./submodule_setup.sh
./vimrc/.vim/bundle/vim-ghost/install.sh
./kvmrc/install.sh
./dockerrc/install.sh
./post_setup.sh
