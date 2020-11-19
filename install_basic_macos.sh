#!/bin/zsh
SCRIPT=$(realpath "$0") && \
    SCRIPTPATH=$(dirname "$SCRIPT") && \
    cd "$SCRIPTPATH" || cd ~/loadrc/

if [ $(uname) = "Linux" ]
then
    exit 0
fi

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew update
brew install \
    Caskroom/cask/xquartz \
    astyle \
    blueutil \
    coreutils \
    dos2unix \
    ffmpeg \
    git \
    git-gui \
    hg \
    htop \
    hub \
    jupyterlab \
    kubectl \
    kubernetes-cli \
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
    wget \
    xpdf

brew cask install \
    kdiff3 \
    libreoffice \
    lynxlet \
    wkhtmltopdf

sudo easy_install pip
sudo pip install --upgrade pip

#./install_nx.sh
