#!/bin/bash -
if [ $(uname) == "Darwin" ]
then
    /Applications/VLC.app/Contents/MacOS/VLC --macosx-continue-playback=2 "$1"
else
    smplayer -fullscreen "$1"
fi
