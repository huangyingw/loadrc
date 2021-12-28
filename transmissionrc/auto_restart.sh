#!/bin/zsh

while ! (/etc/init.d/transmission-daemon status | grep -q "Active: active")
do
    /root/loadrc/bashrc/check_running.sh /root/loadrc/transmissionrc/restart.sh
done
