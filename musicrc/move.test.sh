#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

./move.sh /media/volgrp/mirror/musics/ xiaomi:/data/data/com.arachnoid.sshelper/files/home/SDCard/music/
