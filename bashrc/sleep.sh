#!/bin/bash
if [ `hostname` == "mini14" ]
then
  sudo -u huangyingw gnome-screensaver-command --lock && sudo pm-suspend
else
  sudo pm-suspend
fi
