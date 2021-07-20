#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

export PATH=$(echo $PATH | tr ":" "\n" | grep -v "anaconda3" | tr "\n" ":")
