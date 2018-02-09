#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

CRONRC=$HOME/loadrc/crontabrc/."`hostname`".cron
if [ -f "$CRONRC" ]
then
    crontab "$CRONRC"
fi
