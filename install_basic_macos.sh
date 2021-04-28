#!/bin/zsh
SCRIPT=$(realpath "$0") && \
    SCRIPTPATH=$(dirname "$SCRIPT") && \
    cd "$SCRIPTPATH" || cd ~/loadrc/

if [ $(uname) = "Linux" ]
then
    exit 0
fi

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
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
    iperf \
    iperf3 \
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
    sshfs \
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
