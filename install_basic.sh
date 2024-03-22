#!/bin/bash
SCRIPT=$(realpath "$0") &&
    SCRIPTPATH=$(dirname "$SCRIPT") &&
    cd "$SCRIPTPATH" || cd ~/loadrc/

./install_basic_linux.sh
./install_basic_macos.sh
./configure_gitk.sh
./swith-2-zsh.sh

pip install \
    autoflake \
    autopep8 \
    ipynb-py-convert \
    jupytext \
    pdftotext \
    proxybroker \
    pyautogui

pip3 install \
    autoflake \
    autopep8 \
    bcache-status \
    black \
    ipynb-py-convert \
    jupytext \
    packaging \
    pdftotext \
    proxybroker \
    pyautogui

pip3 install git+https://github.com/gaborvecsei/pdf-split-merge.git

npm -g install \
    csvtojson \
    js-beautify \
    json2csv

go install github.com/nsf/gocode@latest

./zerotierrc/all.sh
./deploy_configurations.sh
./crontabrc/install.sh
