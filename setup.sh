#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

./install_basic.sh
./submodule_setup.sh
./vim_build.sh
./vimrc/.vim/bundle/YouCompleteMe/install.sh
./kvmrc/install.sh
./dockerrc/install.sh
./post_setup.sh
