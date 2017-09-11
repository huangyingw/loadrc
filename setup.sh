#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

ln -fs ./.bashrc ~/.bashrc
ln -fs ./.tmux.conf ~/.tmux.conf
ln -fs ./gitrc/.gitconfig ~/.gitconfig
ln -fs ./gitrc/.globalgitignore ~/.globalgitignore
ln -fs ./vimrc/.vim ~/.vim
ln -fs ./vimrc/.vimrc ~/.vimrc
