#!/bin/zsh
SCRIPT=$(realpath "$0") && \
    SCRIPTPATH=$(dirname "$SCRIPT") && \
    cd "$SCRIPTPATH" || cd ~/loadrc/

if [ $(uname) = "Linux" ]
then
    exit 0
fi

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
brew update
brew upgrade
brew install --cask osxfuse
brew install \
    Caskroom/cask/xquartz \
    astyle \
    blueutil \
    clipper \
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
    tig \
    tmux \
    w3m \
    wakeonlan \
    watch \
    wget \
    xclip

brew cask install \
    kdiff3 \
    libreoffice \
    lynxlet \
    wkhtmltopdf

sudo easy_install pip
sudo pip install --upgrade pip

#./install_nx.sh
