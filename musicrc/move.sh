#!/bin/zsh
SOURCE=$1
TARGET=$2

doCopy () {
    rsync -aHv --progress --remove-source-files --force \
        --exclude \*.zip  \
        --exclude \*.rar  \
        "${SOURCE}" "${TARGET}"
}

doCopy
