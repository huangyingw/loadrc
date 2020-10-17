#!/bin/zsh
SOURCE=$1
TARGET=$2

if [ ! -d "${TARGET}" ]
then
    mkdir -p "${TARGET}"
fi

~/loadrc/bashrc/copy.sh \
    "$SOURCE" "$TARGET" \
    && ~/loadrc/bashrc/copy.sh \
    "$TARGET" "$SOURCE"
