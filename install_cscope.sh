#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

git clone https://github.com/huangyingw/cscope.git
./cscope/build_pre.sh
