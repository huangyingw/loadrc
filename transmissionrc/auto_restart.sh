#!/bin/zsh

while /etc/init.d/transmission-daemon status | grep "Active: failed" > /dev/null
do
    sleep 3
    /etc/init.d/transmission-daemon restart
done
