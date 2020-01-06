#!/bin/zsh
SCRIPT=$(realpath "$0") && \
    SCRIPTPATH=$(dirname "$SCRIPT") && \
    cd "$SCRIPTPATH" || cd ~/loadrc/

if [ $(uname) != "Darwin" ]
then
    ./install_prerequisite.sh
    ./enpass_install.sh
    ./nxrc/install.sh
else
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew update
    brew install \
        Caskroom/cask/xquartz \
        astyle \
        blueutil \
        coreutils \
        git \
        htop \
        hub \
        jupyterlab \
        libtool \
        lynx \
        minikube \
        mosh \
        node \
        openssl \
        rename \
        tig \
        tmux \
        wakeonlan \
        watch \
        xpdf
    brew cask install \
        kdiff3 \
        libreoffice \
        lynxlet \
        wkhtmltopdf
    sudo easy_install pip
    sudo pip install --upgrade pip

fi

pip install \
    pdftotext
sudo -H pip install --upgrade \
    autoflake \
    autopep8
pip3 install git+https://github.com/gaborvecsei/pdf-split-merge.git

./zerotierrc/all.sh
./deploy_configurations.sh
./crontabrc/install.sh
