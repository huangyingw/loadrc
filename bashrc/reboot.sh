#!/bin/zsh

if [ $(uname) = "Darwin" ]
then
    # sudo fdesetup authrestart -user $(whoami) -inputplist < ~/login.plist
    sudo reboot
else
    reboot
fi
