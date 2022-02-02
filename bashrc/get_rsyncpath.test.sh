#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

./get_rsyncpath.sh mba:~/loadrc/ ~/loadrc/
./get_rsyncpath.sh ~/loadrc/ ~/loadrc.bak/
./get_rsyncpath.sh ~/loadrc/ mba:~/loadrc/
./get_rsyncpath.sh ~/loadrc/ mini:~/loadrc/
./get_rsyncpath.sh mini:~/loadrc/ ~/loadrc/
