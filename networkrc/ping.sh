#!/bin/zsh
((count = 10))                           # Maximum number to try.


while [[ $count -ne 0 ]] ; do
    /usr/bin/ping -c 1 8.8.8.8 >> /root/loadrc/crontab.log 2>&1 
    rc=$?
    echo "step --> 2" >> /root/loadrc/crontab.log  

    if [[ $rc -eq 0 ]] ; then
        echo "step --> 3" >> /root/loadrc/crontab.log
        ((count = 1))                    # If okay, flag loop exit.
    else
        echo "step --> 4" >> /root/loadrc/crontab.log
        sleep 1                          # Minimise network storm.
    fi
    ((count = count - 1))                # So we don't go forever.
done

echo "rc --> $rc" >> /root/loadrc/crontab.log
exit $rc
