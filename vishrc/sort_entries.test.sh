#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

./sort_entries.sh /Users/huangyingw/Dropbox/loadrc.home/vimrc.vaa.findresult time
