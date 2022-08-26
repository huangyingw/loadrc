#!/bin/zsh

if [ -z "$1" ]
then
    echo -e "${red}Please provide TARGET ... ${NC}"
    exit 1
fi

TARGET="$1"
jdupes -dNr -X size+:100m -X nostr:/.git/ "$TARGET" 2>&1 | tee ~/loadrc/jdupes.log
