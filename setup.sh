#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

OS=`uname`
./install_basic.sh
./vim_build.sh
./vimrc/.vim/bundle/YouCompleteMe/install.sh
./kvmrc/install.sh
./gpurc/install.sh
./dockerrc/install.sh
./post_setup.sh
