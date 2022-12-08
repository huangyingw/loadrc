#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

cat ~/loadrc/crontabrc/silent.cron > crontab_file
cat ~/loadrc/crontabrc/ssh.cron >> crontab_file
CRONRC=$HOME/loadrc/crontabrc/."`hostname`".cron

if [ -f "$CRONRC" ]
then
    cat "$CRONRC" >> crontab_file
fi

echo2crontab() {
    RESTARTFILE="$1"
    if [ -f "$RESTARTFILE" ]
    then
        echo "*/10 * * * * $RESTARTFILE" >> crontab_file
    fi
}

while read -r line || [ -n "$line" ]
do
    echo2crontab "$line"
done < restartfiles

sort -u crontab_file -o crontab_file
crontab crontab_file
