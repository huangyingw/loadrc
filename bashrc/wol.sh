#!/bin/bash
if [ -z "$1" ]
then
    wakeonlan 10:7b:44:f0:e7:2f #server
    ping server
elif [ "$1" == "mldonkey" ]
then
    wakeonlan 00:01:c0:12:92:a2 #mldonkey
    ping mldonkey
elif [ "$1" == "thinkpad" ]
then
    wakeonlan 00:21:cc:c0:53:a9 #thinkpad
    ping thinkpad
elif [ "$1" == "toshiba" ]
then
    wakeonlan b8:70:f4:ce:3d:f3 #toshiba
    ping toshiba
elif [ "$1" == "mini" ]
then
    wakeonlan 00:01:c0:15:fa:ed #mini
    ping mini
elif [ "$1" == "server" ]
then
    wakeonlan 50:e5:49:ca:fd:04 #server
    ping server
elif [ "$1" == "movie" ]
then
    wakeonlan 50:e5:49:ca:fd:04 #movie
    ping movie
fi
