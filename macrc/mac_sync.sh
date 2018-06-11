#!/bin/bash -

if [ -z "$1" ]
then
    echo -e "${red}Please provide TARGET server ... ${NC}"
    exit 1
fi

TARGET="$1"

mac_sync () {
    folder="$1"
    echo rsync -aHv --progress --delete-during --force \
        "$folder" \
        "$TARGET":"$folder"
}

while read -r line || [[ -n "$line" ]]
do
    mac_sync "$line"
done < mac_sync.list
