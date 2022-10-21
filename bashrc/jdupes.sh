#!/bin/zsh

if [ -z "$1" ]
then
    echo -e "${red}Please provide TARGET ... ${NC}"
    exit 1
fi

TARGET="$1"
dt=$(date '+%m_%d_%Y_%H_%M_%S');
logFile="$TARGET/jdupes.$dt.log"
jdupes -dNr -X size+:100m -X nostr:/.git/ "$TARGET" 2>&1 | tee "$logFile"
