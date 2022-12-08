#!/bin/zsh
SCRIPT=$(realpath "$0") && \
    SCRIPTPATH=$(dirname "$SCRIPT") && \
    cd "$SCRIPTPATH" || cd ~/loadrc/

if [ $(uname) = "Linux" ]
then
    exit 0
fi

xcode-select --install

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
    azure-cli \
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
    poppler \
    pv \
    redis \
    rename \
    rsync \
    sbt \
    slurm \
    sponge \
    tig \
    w3m \
    wakeonlan \
    watch \
    wget \
    xclip \
    xmlto \
    yq

brew cask install \
    kdiff3 \
    libreoffice \
    lynxlet \
    wkhtmltopdf

brew tap redis-stack/redis-stack
brew install --cask redis-stack

sudo easy_install pip
sudo pip install --upgrade pip

#./install_nx.sh
