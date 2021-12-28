#!/bin/zsh

/root/loadrc/networkrc/ping.sh 
rc=$?

if [[ $rc -eq 0 ]]
then
    echo "say The internet is back up."
else
    reboot
fi
