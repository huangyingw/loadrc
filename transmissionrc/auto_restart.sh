#!/bin/zsh

while ! (/etc/init.d/transmission-daemon status | grep -q "Active: active")
do
    /root/loadrc/bashrc/run_once_script_checker.sh /root/loadrc/transmissionrc/restart.sh
done
