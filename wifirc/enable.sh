#!/bin/zsh
if [ $(uname) != "Darwin" ]
then
    PHY=$(iw list | awk '/Wiphy/{print $2}')
    iw "$PHY" wowlan enable magic-packet disconnect
fi
