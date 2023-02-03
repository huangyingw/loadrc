#!/bin/bash

# find the uuid by nmcli con show
# and put this script, which is owned by root and executable, in the folder: /etc/NetworkManager/dispatcher.d

# the following command to get the wifi device:

DEV=$(
    for dev in `ls /sys/class/net`; do
        [ -d "/sys/class/net/$dev/wireless" ] && echo "$dev"
    done
)

TARGET_ID=$(nmcli connection show | grep wifi | sed 's/.*[^0-9a-z]\(\([0-9a-z]*-\)\{4\}[0-9a-z]*\).*/\1/g')

if [ "$CONNECTION_UUID" = "$TARGET_ID" ]
then
    if [ "$2" = "down" ]; then
        sleep 5
        nmcli con up uuid $CONNECTION_UUID
    fi
fi
