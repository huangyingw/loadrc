#!/bin/bash

wlan=`/sbin/ifconfig wlan0 | grep inet\ addr | wc -l`
if [ $wlan -eq 0 ]; then
    service network-manager restart
else
    echo WIFI IS UP
fi
