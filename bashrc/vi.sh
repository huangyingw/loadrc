#!/bin/bash
if [ -z "$1" ]
then
    vim `~/loadrc/bashrc/find_up.sh "$PWD" files.proj`
else
    vim "$1"
fi
