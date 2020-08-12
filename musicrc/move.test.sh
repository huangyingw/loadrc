#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

./move.sh mini:/media/mirror2/mirror2/musics/ "/Volumes/NO NAME/musics"
