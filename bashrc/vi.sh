#!/bin/bash
if [ -z "$1" ]
then
    nvim `~/loadrc/bashrc/find_up.sh "$PWD" files.proj`
else
    nvim "$1"
fi
