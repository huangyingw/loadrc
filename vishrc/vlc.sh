#!/bin/zsh

if [ ! -f "$1" ]
then
    exit
fi

if [ $(uname) = "Darwin" ]
then
    /Applications/VLC.app/Contents/MacOS/VLC -f --macosx-continue-playback=2 "$1"
else
    smplayer "$1"
    #smplayer -fullscreen "$1"
fi
