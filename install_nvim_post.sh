#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

mkdir -p ~/.config/nvim/
~/loadrc/bashrc/ln_fs.sh ~/loadrc/vimrc/.vim ~/.vim
~/loadrc/bashrc/ln_fs.sh ~/loadrc/vimrc/.vimrc ~/.vimrc
~/loadrc/bashrc/ln_fs.sh ~/loadrc/.config/nvim/init.vim ~/.config/nvim/init.vim
rm -fv ~/.viminfo*
./gitrc/gclean.sh
