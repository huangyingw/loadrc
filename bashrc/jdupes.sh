#!/bin/bash -

if [ -z "$1" ]
then
    echo -e "${red}Please provide TARGET ... ${NC}"
    exit 1
fi

~/loadrc/bashrc/move67.sh

TARGET="$1"
MIRRORCHECK=$HOME/loadrc/."`hostname`".mirror.check

jdupes -1dNr "$TARGET" 2>&1 | tee ~/loadrc/jdupes.log && \
    if [ -f ${MIRRORCHECK} ] ; \
    then \
        ~/loadrc/bashrc/sleep.sh ; \
    fi && \
    nvim ~/loadrc/jdupes.log
