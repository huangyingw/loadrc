#!/bin/bash
OS=`uname`
if [ $OS == "Darwin" ];
then
    ~/loadrc/dockerrc/killDockers.sh
    containerCounts=$(docker ps|wc -l)

    if [ $containerCounts -gt 1 ]
    then
        echo -e "${red}Please stop all the running containers first... ${NC}"
        exit 1
    else
        pmset sleepnow
    fi
else
    sudo -u huangyingw gnome-screensaver-command --lock && sudo pm-suspend
fi
