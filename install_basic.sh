#!/bin/zsh
SCRIPT=$(realpath "$0") && \
    SCRIPTPATH=$(dirname "$SCRIPT") && \
    cd "$SCRIPTPATH" || cd ~/loadrc/

./install_basic_linux.sh
./install_basic_macos.sh

pip install \
    pdftotext

sudo -H pip install --upgrade \
    autoflake \
    autopep8

pip3 install git+https://github.com/gaborvecsei/pdf-split-merge.git

npm -g install \
    csvtojson \
    js-beautify \
    json2csv

./zerotierrc/all.sh
./deploy_configurations.sh
./crontabrc/install.sh
