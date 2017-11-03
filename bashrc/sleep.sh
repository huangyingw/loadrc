#!/bin/bash
OS=`uname`
if [ $OS == "Darwin" ]
then
    pmset sleepnow
else
    iw phy0 wowlan enable magic-packet disconnect && pm-suspend
fi
