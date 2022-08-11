#!/bin/zsh
SCRIPT=$(realpath "$0") && \
    SCRIPTPATH=$(dirname "$SCRIPT") && \
    cd "$SCRIPTPATH" || cd ~/loadrc/

if [ $(uname) = "Linux" ]
then
    exit 0
fi

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
git -C $(brew --repository homebrew/core) checkout master
brew update
brew upgrade
brew install \
    mosh \
    tmux

./deploy_configurations.sh

brew install \
    Caskroom/cask/xquartz \
    astyle \
    blueutil \
    brightness \
    clipper \
    coreutils \
    dialog \
    dos2unix \
    ffmpeg \
    git \
    git-gui \
    graphviz \
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
    openssl \
    parallel \
    patchutils \
    php \
    pv \
    rename \
    rsync \
    sponge \
    tig \
    w3m \
    wakeonlan \
    watch \
    wget \
    xclip \
    xmlto

brew cask install \
    kdiff3 \
    libreoffice \
    lynxlet \
    wkhtmltopdf

sudo easy_install pip
sudo pip install --upgrade pip

#./install_nx.sh
