#!/bin/zsh
((count = 10))                           # Maximum number to try.

while [[ $count -ne 0 ]] ; do
    /usr/bin/ping -c 1 8.8.8.8
    rc=$?

    if [[ $rc -eq 0 ]] ; then
        ((count = 1))                    # If okay, flag loop exit.
    else
        sleep 1                          # Minimise network storm.
    fi
    ((count = count - 1))                # So we don't go forever.
done

exit $rc
