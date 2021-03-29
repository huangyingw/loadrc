#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

apt install -y netatalk avahi-daemon
cp -fv ./etc/netatalk/afp.conf /etc/netatalk/afp.conf

mkdir -p /srv/netatalk/time-machine
chown nobody:nogroup /srv/netatalk/time-machine
chmod -R 777 /srv/netatalk/time-machine

service netatalk restart
