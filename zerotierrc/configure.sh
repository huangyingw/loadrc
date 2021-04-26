#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

deploy_configs() {
    TARGET="$1"
    SOURCE=~/loadrc/hosts/"`hostname`$TARGET"

    if [ -f "$SOURCE" ]
    then
        sudo cp -fv "$SOURCE" "$TARGET"
    fi
}

while read -r line || [[ -n "$line" ]]
do
    deploy_configs "$line"
done < zerotierrc.conf

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
