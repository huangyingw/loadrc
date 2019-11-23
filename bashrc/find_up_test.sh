#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

./find_up.sh "/Users/yhuang/loadrc/dvim" ".git"
./find_up.sh "/Users/yhuang/loadrc/dvim" "files.proj"
