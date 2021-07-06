#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

if [ $(uname) != "Darwin" ]
then
    add-apt-repository -y ppa:neovim-ppa/stable
    apt-get update
    apt-get upgrade -y
    apt-get install -y \
        exuberant-ctags \
        neovim \
        python-dev \
        python3-dev \
        python3-pip
    pip3 install pynvim
    pip3 install jedi
else
    brew install \
        coreutils \
        neovim \
        python
    brew reinstall python
    sudo pip3 install --upgrade neovim 
    sudo pip3 install pynvim jedi 
    #brew install --with-toolchain --with-clang llvm
fi

./neovim/install.sh
