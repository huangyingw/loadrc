#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

if [ $(uname) != "Darwin" ]
then
    apt-get update
    apt-get upgrade -y
    apt-get install -y \
        neovim \
        python-dev \
        python-pip \
        python3-pip
else
    brew install \
        coreutils \
        neovim
    brew link --overwrite neovim
fi

pip install --upgrade neovim
pip2 install --upgrade neovim
pip3 install --upgrade neovim

mkdir -p ~/.config/nvim/
ln -fs ~/loadrc/.config/nvim/init.vim ~/.config/nvim/init.vim
rm -v .viminfo*
