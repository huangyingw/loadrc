#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

if [ $(uname) = "Darwin" ]
then
    exit 0
fi

apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

apt-get install -y docker.io docker-compose
systemctl enable docker

./nvidia-docker_install.sh

mkdir -p /media/nvme/var/lib/docker/
/etc/init.d/docker stop \
    && ~/loadrc/bashrc/mklnk.sh /var/lib/docker/ /media/nvme/var/lib/docker/
