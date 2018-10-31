#!/bin/bash
CHECKFILE=/media/volgrp/to_check_raid
if ! [ -f "$CHECKFILE" ]
then
    return
fi
DEVICE=`mdadm -D --scan|awk '{print $2}'`
raid_state=$(mdadm -D "$DEVICE" | awk '/State :/{print $3}')

if [[ "$raid_state" != "clean" ]] && [[ "$raid_state" != "active" ]]
then
    echo dangerous
    echo dangerous
    echo dangerous
fi
