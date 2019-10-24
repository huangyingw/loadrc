#!/bin/bash -
file="$1"
target="$1.sh"

if [ ! -f "$target" ]
then
    cp -nv ~/loaded/imvurc/generate_sh.template "$target"
fi
