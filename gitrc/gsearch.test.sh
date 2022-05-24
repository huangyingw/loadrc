#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

./gsearch.sh GitSearch ~/loadrc/gitsearch.findresult ~/loadrc/gitsearch.findresult.tmp
