#!/bin/zsh -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

if [ $(uname) == "Darwin" ]
then
    exit 0
fi

apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
apt-get update
apt-get install -y docker-ce docker-compose

./nvidia-docker_install.sh

mkdir -p /media/nvme/var/lib/docker/
/etc/init.d/docker stop \
    && ~/loadrc/bashrc/mklnk.sh /var/lib/docker/ /media/nvme/var/lib/docker/
