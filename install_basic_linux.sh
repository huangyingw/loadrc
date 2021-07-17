#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"


if [ $(uname) = "Darwin" ]
then
    exit 0
fi

./install_prerequisite.sh
./install_gh.sh
./install_nodejs.sh
./install_time_machine.sh
./enpass_install.sh
./nxrc/install.sh
./kubernetesrc/install.sh
cp -fv /bin/true /usr/bin/true
cp -fv ./wifirc/autoconnect.sh /etc/NetworkManager/dispatcher.d/
systemctl disable NetworkManager-wait-online.service
