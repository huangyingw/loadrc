#!/bin/zsh

SOURCE="$1"
realpath "$1" && SOURCE=$(realpath "$1")
TARGET="$2"

if [ "$SOURCE" != "$TARGET" ]
then
    if [ -L "$TARGET" ]
    then
        rm "$TARGET"
    fi

    if [ -f "$TARGET" ]
    then
        cp -nv "$TARGET" "$TARGET".bak
    fi

    ln -fs "$SOURCE" "$TARGET"
fi
