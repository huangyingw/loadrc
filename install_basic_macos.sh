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
    jq \
    jupyterlab \
    kubectl \
    kubernetes-cli \
    libtool \
    lynx \
    minikube \
    mosh \
    openssl \
    rename \
    sshfs \
    tig \
    tmux \
    w3m \
    wakeonlan \
    watch \
    wget \
    xpdf

brew cask install \
    kdiff3 \
    libreoffice \
    lynxlet \
    wkhtmltopdf

brew install --cask osxfuse

sudo easy_install pip
sudo pip install --upgrade pip

#./install_nx.sh
