#!/bin/zsh

SOURCE=`realpath "$1"`
TARGET=`realpath "$2"`

if [ "$SOURCE" != "$TARGET" ]
then
    cp -nv "$TARGET" "$TARGET".bak
    if [ -L "$TARGET" ]
    then
        rm "$TARGET"
    fi
    ln -fs "$SOURCE" "$TARGET"
fi
