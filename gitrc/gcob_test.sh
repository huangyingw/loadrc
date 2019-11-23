#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

./gcob.sh cscope/autoload.dev
./gcob.sh cscope/autoload
