#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

./prune.sh /Users/yhuang/loadrc/vimrc/.vim/bundle/vundle.vim/doc/vundle.txt
