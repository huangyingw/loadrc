#!/bin/bash
OS=`uname`
if [ $OS == "Darwin" ];
then
    pmset sleepnow
else
    sudo -u huangyingw gnome-screensaver-command --lock && sudo pm-suspend
fi
