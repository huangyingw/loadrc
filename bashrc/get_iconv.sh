#!/bin/zsh

host=$(~/loadrc/bashrc/parse_host.sh "$1" )

if ( ssh -q "$host" "uname" | grep -q Darwin )
then
    echo "utf-8-mac"
else
    echo "utf-8"
fi
