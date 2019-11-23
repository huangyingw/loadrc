#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

vagrant box add "https://artifactory.corp.imvu.com/artifactory/api/vagrant/vagrant-imvu/lint-sandbox" --name lint-sandbox
vagrant up
