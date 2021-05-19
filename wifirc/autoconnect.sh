#!/bin/bash

# find the uuid by nmcli con show 
# and put this script, which is owned by root and executable, in the folder: /etc/NetworkManager/dispatcher.d

if [ "$CONNECTION_UUID" = "df31faf5-3440-49ec-be88-9e040176663e" ]
then
    if [ "$2" = "down" ]; then
        sleep 10
        nmcli con up uuid $CONNECTION_UUID
    fi
fi
