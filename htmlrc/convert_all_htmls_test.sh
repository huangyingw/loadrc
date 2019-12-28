#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

./convert_all_htmls.sh ../vimrc/.vim/bundle/vim-autoformat/
