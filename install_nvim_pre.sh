#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    exuberant-ctags \
    python-dev \
    python3-dev \
    python3-pip

pip3 install pynvim
pip3 install jedi

brew install \
    coreutils \
    python

brew reinstall python
sudo pip3 install pynvim jedi

./neovim/install_prerequisite.sh
./neovim/install.sh
