#!/bin/zsh -

SOURCE=`realpath "$1"`
TARGET=`realpath "$2"`

if [ "$SOURCE" != "$TARGET" ]
then
    cp -nv "$TARGET" "$TARGET".bak
    ln -fs "$SOURCE" "$TARGET" 
fi
