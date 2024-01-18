#!/bin/zsh
target=$(echo "$1" | sed  -e "s/\/$//g")
if [ -z "$1" ]
then
    wakeonlan -i 192.168.2.2 10:7b:44:f0:e7:2f #server
    wakeonlan b0:ea:bc:09:20:c6 #server wifi
    wakeonlan 10:7b:44:f0:e7:2f #server mother board Ethernet
    wakeonlan 88:c9:b3:b0:e9:1e #server 10G
    wakeonlan 00:e0:4c:68:03:cd
    wakeonlan 00:e0:4c:00:07:a8
    wakeonlan 88:c9:b3:b0:e9:1e
    wakeonlan 88:c9:b3:b0:e9:1f
    ping server
elif [ "$target" = "haikou" ]
then
    wakeonlan 00:01:c0:12:92:a2 #haikou
    ping haikou
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
    wakeonlan 88:c9:b3:b0:e9:1e #server 10G
    ping server
elif [ "$target" = "movie" ]
then
    wakeonlan 50:e5:49:ca:fd:04 #movie
    wakeonlan 1c:87:2c:b7:a1:ce #movie wifi
    wakeonlan -i 192.168.1.2 00:0a:cd:1e:e9:be #movie
    ping movie
elif [ "$target" = "mini2" ]
then
    wakeonlan f4:4e:e3:fd:1c:e5 #mini2 wifi
    wakeonlan 00:E0:4C:00:07:A8 #mini2 wired
    ping mini2
elif [ "$target" = "mba" ]
then
    wakeonlan FC:E2:6C:07:12:2E #wifi
    ping mba
elif [ "$target" = "mbp" ]
then
    wakeonlan AC:BC:32:87:BF:DB #wifi
    ping mbp
elif [ "$target" = "tiny" ]
then
    wakeonlan e4:5f:01:81:11:55
    ping tinypilot
fi
