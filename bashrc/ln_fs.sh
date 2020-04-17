#!/bin/zsh

SOURCE="$1"
realpath "$1" && SOURCE=$(realpath "$1")
TARGET="$2"
realpath "$2" && TARGET=$(realpath "$2")

if [ "$SOURCE" != "$TARGET" ]
then
    cp -nv "$TARGET" "$TARGET".bak
    if [ -L "$TARGET" ]
    then
        rm "$TARGET"
    fi
    ln -fs "$SOURCE" "$TARGET"
fi
