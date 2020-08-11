#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

./move.sh /media/mirror2/mirror2/musics/ /media/sdcard/musics/
