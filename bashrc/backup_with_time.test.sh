#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

./backup_with_time.sh /var/lib/transmission-daemon/.config/transmission-daemon
