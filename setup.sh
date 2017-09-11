#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

ln -fs "$SCRIPTPATH" ~/loadrc
ln -fs ~/loadrc/.bashrc ~/.bashrc
ln -fs ~/loadrc/.tmux.conf ~/.tmux.conf
ln -fs ~/loadrc/gitrc/.gitconfig ~/.gitconfig
ln -fs ~/loadrc/gitrc/.globalgitignore ~/.globalgitignore
ln -fs ~/loadrc/vimrc/.vim ~/.vim
ln -fs ~/loadrc/vimrc/.vimrc ~/.vimrc
git submodule init
git submodule sync
git submodule update
./macvim/build.sh
./vimrc/.vim/bundle/YouCompleteMe/install.sh
