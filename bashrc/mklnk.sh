#!/bin/zsh
SOURCE=`realpath "$1"`
TARGET=`realpath "$2"`

if [ "$SOURCE" = "$TARGET" ]
then
    echo -e "${red} source and target are identical ... ${NC}"
    exit 1
fi

if [ -f "$TARGET" ]
then
    echo -e "${red}Please consider backup/move the target folder --> $TARGET first ! ... ${NC}"
    exit 1
fi

~/loadrc/bashrc/move.sh "$SOURCE" "$TARGET"
~/loadrc/bashrc/ln_fs.sh "$TARGET" "$SOURCE"
