#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

mkdir -p ~/.config/nvim/
~/loadrc/bashrc/ln_fs.sh ~/loadrc/vimrc/.vim ~/.vim || true
~/loadrc/bashrc/ln_fs.sh ~/loadrc/vimrc/.vimrc ~/.vimrc || true
~/loadrc/bashrc/ln_fs.sh ~/loadrc/.config/nvim/init.vim ~/.config/nvim/init.vim || true
rm -fv ~/.viminfo* || true
./gitrc/gclean.sh || true
