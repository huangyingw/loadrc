#!/bin/zsh

if [ ! -f "$1" ]
then
    exit
fi

if [ $(uname) = "Darwin" ]
then
    /Applications/VLC.app/Contents/MacOS/VLC --sub-language Chinese --sub-autodetect-file -f --macosx-continue-playback=2 --rate=2.0 "$1"
else
    #smplayer "$1"
    smplayer -fullscreen "$1"
fi
