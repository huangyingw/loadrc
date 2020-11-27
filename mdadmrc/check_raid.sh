#!/bin/zsh
DEVICE=`mdadm -D --scan|awk '{print $2}'`

if [ -z "$DEVICE" ]
then
    return
fi

raid_state=$(mdadm -D "$DEVICE" | awk '/State :/{print $3}')

if [[ "$raid_state" != "clean" ]] && [[ "$raid_state" != "active" ]]
then
    echo dangerous
    echo dangerous
    echo dangerous
fi
# watch cat /proc/mdstat
