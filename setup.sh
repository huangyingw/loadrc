#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

OS=`uname`
if [ $OS != "Darwin" ]
then
    ./install_basic.sh
fi
./deploy_links.sh
git submodule init
git submodule sync
git submodule update
git submodule foreach ~/loadrc/gitrc/gps.sh
git submodule foreach ~/loadrc/gitrc/gsync.sh

if [ $OS == "Darwin" ]
then
    ./macvim/build.sh
else
    . /etc/lsb-release
    cd ./pkg-vim/
    git co "$DISTRIB_CODENAME".fix \
        && ./build.sh
    cd -
fi
./vimrc/.vim/bundle/YouCompleteMe/install.sh
if [ $OS == "Darwin" ]
then
    ./bashrc/cscope.sh
fi
./gitrc/gclean.sh
if [ $OS != "Darwin" ]
then
    ./kvmrc/install.sh
    ./gpurc/install.sh
    ./dockerrc/install.sh
    curl -s https://install.zerotier.com/ | bash
    zerotier-cli join 93afae5963560e41
fi
