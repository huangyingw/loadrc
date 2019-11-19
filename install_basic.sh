#!/bin/zsh -
SCRIPT=$(realpath "$0") && \
    SCRIPTPATH=$(dirname "$SCRIPT") && \
    cd "$SCRIPTPATH" || cd ~/loadrc/

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
        Caskroom/cask/xquartz \
        blueutil \
        coreutils \
        git \
        htop \
        libtool \
        lynx \
        mosh \
        openssl \
        rename \
        tig \
        tmux \
        wakeonlan \
        xpdf
    brew cask install \
        kdiff3 \
        lynxlet
    sudo easy_install pip
    sudo pip install --upgrade pip

fi

pip install \
    pdftotext
pip3 install git+https://github.com/gaborvecsei/pdf-split-merge.git

./zerotierrc/all.sh
./deploy_configurations.sh
./crontabrc/install.sh
