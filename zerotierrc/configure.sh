#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

echo2crontab() {
    RESTARTFILE="$1"
    if [ -f "$RESTARTFILE" ]
    then
        echo "*/10 * * * * $RESTARTFILE" >> crontab_file
    fi
}

crontab -l > crontab_file

while read -r line || [[ -n "$line" ]]
do
    echo2crontab "$line"
done < ~/loadrc/crontabrc/restartfiles

sort -u crontab_file -o crontab_file
crontab crontab_file
