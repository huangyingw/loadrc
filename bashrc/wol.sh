#!/bin/zsh
target=$(echo "$1" | sed  -e "s/\/$//g")
if [ -z "$1" ]
then
    wakeonlan -i 192.168.2.2 10:7b:44:f0:e7:2f #server
    wakeonlan b0:ea:bc:09:20:c6 #server wifi
    wakeonlan 10:7b:44:f0:e7:2f #server mother board Ethernet
    ping server
elif [ "$target" = "mldonkey" ]
then
    wakeonlan 00:01:c0:12:92:a2 #mldonkey
    ping mldonkey
elif [ "$target" = "thinkpad" ]
then
    wakeonlan 00:21:cc:c0:53:a9 #thinkpad
    ping thinkpad
elif [ "$target" = "toshiba" ]
then
    wakeonlan b8:70:f4:ce:3d:f3 #toshiba
    ping toshiba
elif [ "$target" = "vserver" ]
then
    wakeonlan 00:01:c0:15:fa:ed #vserver
    ping vserver
elif [ "$target" = "mini" ]
then
    wakeonlan 00:01:c0:15:fa:ed #mini
    ping mini
elif [ "$target" = "server" ]
then
    wakeonlan -i 192.168.2.12 10:7b:44:f0:e7:2f #server
    wakeonlan b0:ea:bc:09:20:c6 #server wifi
    ping server
elif [ "$target" = "movie" ]
then
    wakeonlan 50:e5:49:ca:fd:04 #movie
    wakeonlan 1c:87:2c:b7:a1:ce #movie wifi
    wakeonlan -i 192.168.1.2 00:0a:cd:1e:e9:be #movie
    ping movie
fi
