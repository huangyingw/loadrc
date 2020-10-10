#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"


if [ $(uname) = "Darwin" ]
then
    exit 0
fi

./install_prerequisite.sh
./install_nodejs.sh
./enpass_install.sh
./nxrc/install.sh
cp -fv /bin/true /usr/bin/true
systemctl disable NetworkManager-wait-online.service
