#!/bin/zsh
export LC_ALL=C

comm -2 -3 <(sort "$1") <(sort "$2") > "$1".findresult
comm -1 -3 <(sort "$1") <(sort "$2") > "$2".findresult
cp -fv "$1".findresult "$1"
cp -fv "$2".findresult "$2"
