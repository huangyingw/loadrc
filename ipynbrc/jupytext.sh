#!/bin/zsh
TARGET="$PWD"

if [ -n "$1" ]
then
    TARGET="$1"
fi

find "$TARGET" -type f -name \*.ipynb -exec jupytext --sync {} \;
