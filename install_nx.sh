#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

wget -nc https://download.nomachine.com/download/6.12/MacOSX/nomachine_6.12.3_8.dmg
sudo hdiutil attach nomachine_6.12.3_8.dmg
sudo installer -package /Volumes/NoMachine/NoMachine.pkg -target /
