#!/bin/bash
OS=`uname`
if [ $OS == "Darwin" ];
then
    ~/loadrc/dockerrc/killDockers.sh ; pmset sleepnow
else
    sudo -u huangyingw gnome-screensaver-command --lock && sudo pm-suspend
fi
