#!/bin/zsh

if [ -z "$1" ]
then
    echo -e "${red}Please provide TARGET ... ${NC}"
    exit 1
fi

TARGET="$1"
MIRRORCHECK=$HOME/loadrc/."`hostname`".mirror.check

crontab -r
if [ -f ${MIRRORCHECK} ] ; \
then \
    ~/loadrc/bashrc/move67.sh ; \
    fi && \
    jdupes -1dNr "$TARGET" 2>&1 | tee ~/loadrc/jdupes.log && \
    if [ -f ${MIRRORCHECK} ] ; \
    then \
        ~/loadrc/bashrc/sleep.sh ; \
        fi ; \
        nvim ~/loadrc/jdupes.log
