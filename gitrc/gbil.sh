#!/bin/zsh
if [ ! -f gbil.log ]
then
    echo git bisect start > gbil.log
fi
