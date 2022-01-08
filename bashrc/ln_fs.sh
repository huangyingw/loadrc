#!/bin/zsh

SOURCE="$1"
realpath "$1" && SOURCE=$(realpath "$1")
TARGET="$2"

if [ "$SOURCE" != "$TARGET" ]
then
    if [ -L "$TARGET" ]
    then
        rm "$TARGET"
    elif [ -f "$TARGET" ]
    then
        cp -nv "$TARGET" "$TARGET".bak
    elif [ -d "$TARGET" ]
    then
        ~/loadrc/bashrc/move.sh "$TARGET" "$TARGET".bak
    fi

    ln -fs "$SOURCE" "$TARGET"
fi
