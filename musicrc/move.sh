#!/bin/zsh
SOURCE=$1
TARGET=$2

doCopy () {
    rsync -aHv --progress --remove-source-files --max-size="$1" --force \
        --exclude \*.zip  \
        --exclude \*.rar  \
        "${SOURCE}" "${TARGET}"
}

COUNTER=10
while [[  $COUNTER -lt 1900 ]]; do
    MAXSIZE="$COUNTER""m"
    doCopy "$MAXSIZE"
    let COUNTER=COUNTER+10
done
