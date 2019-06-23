#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

if [ $(uname) != "Darwin" ]
then
    add-apt-repository -y ppa:neovim-ppa/unstable
    apt-get update
    apt-get upgrade -y
    apt-get install -y \
        exuberant-ctags \
        neovim \
        python-dev \
        python-pip \
        python3-pip
else
    brew install \
        coreutils \
        neovim \
        python
    brew link --overwrite neovim
    #brew install --with-toolchain --with-clang llvm
fi

pip3 uninstall -y pynvim
pip3 install pynvim

pip3 install jedi
