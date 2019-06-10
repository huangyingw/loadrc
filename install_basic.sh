#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

if [ $(uname) != "Darwin" ]
then
    ./install_prerequisite.sh
else
    brew install \
        blueutil \
        coreutils \
        libtool
    brew cask install \
        kdiff3
    brew link --overwrite neovim
fi

pip install \
    pdftotext

./nxrc/install.sh
./enpass_install.sh
./chrome_install.sh
./zerotierrc/zerotier_install.sh
./deploy_configurations.sh
