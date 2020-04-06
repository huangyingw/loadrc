#!/bin/zsh
SCRIPT=$(realpath "$0") && \
    SCRIPTPATH=$(dirname "$SCRIPT") && \
    cd "$SCRIPTPATH" || cd ~/loadrc/

./install_basic.sh
~/loadrc/gitrc/gpl.sh
./install_nvim.sh
./gpurc/install.sh
./install_vagrant.sh
./install_flacon.sh
./cscope/build.sh
./jdupes/install.sh
./submodule_setup.sh
./kvmrc/install.sh
./dockerrc/install.sh
#./kubernetesrc/install.sh
./post_setup.sh
