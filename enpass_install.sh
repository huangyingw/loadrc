#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

echo "deb https://apt.enpass.io/ stable main" > \
    /etc/apt/sources.list.d/enpass.list

#And import key that is used to sign the release:
wget -O - https://apt.enpass.io/keys/enpass-linux.key | apt-key add -
apt-get update
apt-get install -y enpass
