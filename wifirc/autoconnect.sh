#!/bin/bash

# find the uuid by nmcli con show
# and put this script, which is owned by root and executable, in the folder: /etc/NetworkManager/dispatcher.d

# the following command to get the wifi device:

DEV=$(
    for dev in `ls /sys/class/net`; do
        [ -d "/sys/class/net/$dev/wireless" ] && echo "$dev"
    done
) 

TARGET_ID=$(nmcli connection show | grep $DEV | sed 's/.*[^0-9a-z]\(\([0-9a-z]*-\)\{4\}[0-9a-z]*\).*/\1/g')

if [ "$CONNECTION_UUID" = "1c853a09-cf79-4a54-86fa-9efb5e447ea8" ]
then
    if [ "$2" = "down" ]; then
        sleep 10
        nmcli con up uuid $CONNECTION_UUID
    fi
fi
