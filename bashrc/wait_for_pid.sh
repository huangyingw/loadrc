#!/bin/zsh
pid="$1"

if [ $(uname) = "Darwin" ]
then
    lsof -p "$pid" +r 1 &>/dev/null
else
    tail --pid="$pid" -f /dev/null
fi
