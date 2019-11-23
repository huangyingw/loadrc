#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

git submodule init
git submodule sync
git submodule update
git submodule foreach ~/loadrc/gitrc/gps.sh
git submodule foreach ~/loadrc/gitrc/gsync.sh
