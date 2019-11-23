#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

~/loadrc/gitrc/gpl.sh
./install_basic.sh
./install_nvim.sh
./gpurc/install.sh
./install_vagrant.sh
./install_flacon.sh
./cscope/build.sh
./jdupes/install.sh
. ./gitrc/submodule_update.sh
./kvmrc/install.sh
./dockerrc/install.sh
./post_setup.sh
