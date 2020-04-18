#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

if [ $(uname) != "Darwin" ]
then
    apt-get build-dep -y vagrant ruby-libvirt
    apt install -y \
        vagrant \
        virtualbox

    apt-get install -y qemu libvirt-bin ebtables dnsmasq
    apt-get install -y libxslt-dev libxml2-dev libvirt-dev zlib1g-dev ruby-dev
    vagrant plugin install vagrant-libvirt
else
    brew cask install virtualbox vagrant
fi
