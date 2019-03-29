#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

CRONRC=$HOME/loadrc/crontabrc/."`hostname`".cron
if [ -f "$CRONRC" ]
then
    crontab "$CRONRC"
fi


if [ $(uname) != "Darwin" ]
then
    crontab -l > crontab_file
    cat ./zerotier.cron >> crontab_file
    cat ./wifi.cron >> crontab_file
    sort -u crontab_file -o crontab_file
    crontab crontab_file
fi
