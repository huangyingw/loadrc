#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

if [ $(uname) != "Darwin" ]
then
    ./install_prerequisite.sh
    ./enpass_install.sh
    ./nxrc/install.sh
    ./chrome_install.sh
else
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew update
    brew install \
        blueutil \
        coreutils \
        git \
        Caskroom/cask/xquartz \
        libtool \
        lynx \
        tig \
        tmux \
        xpdf
    brew cask install \
        kdiff3 \
        lynxlet
    sudo easy_install pip
    sudo pip install --upgrade pip

fi

pip install \
    pdftotext

./zerotierrc/all.sh
./deploy_configurations.sh
./crontabrc/install.sh
