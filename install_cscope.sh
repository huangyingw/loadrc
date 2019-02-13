#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

git clone git@github.com:huangyingw/cscope.git
./cscope/build_pre.sh
