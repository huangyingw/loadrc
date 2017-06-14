#!/bin/bash
GMEDEFAULT=gme.default
if [ ! -f "$GMEDEFAULT" ];
then
    echo -e "${red}git merge is not allowed, without tag file: gme.default ... ${NC}"
    exit 1
fi
git merge "$1" \
    && ~/loadrc/gitrc/gps.sh
