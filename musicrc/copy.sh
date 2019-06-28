#!/bin/bash -
SOURCE=$1
TARGET=$2

doCopy () {
    rsync -aHv --progress --max-size="$1" --force \
        --exclude \*.zip  \
        --exclude \*.rar  \
        "${SOURCE}" "${TARGET}"
}

crontab -r
COUNTER=10
while [  $COUNTER -lt 400 ]; do
    MAXSIZE="$COUNTER""m"
    doCopy "$MAXSIZE"
    let COUNTER=COUNTER+10
done
