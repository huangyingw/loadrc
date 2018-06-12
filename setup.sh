#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

~/loadrc/gitrc/gpl.sh
./install_basic.sh
./submodule_setup.sh
./vim_build.sh
./vimrc/.vim/bundle/YouCompleteMe/install.sh
./vimrc/.vim/bundle/vim-ghost/install
./kvmrc/install.sh
./dockerrc/install.sh
./post_setup.sh
