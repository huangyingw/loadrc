#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

# https://dae.me/blog/1660/concisest-guide-to-setting-up-time-machine-server-on-ubuntu-server-12-04/

apt-get install -y \
    avahi-daemon \
    libc6-dev \
    libnss-mdns \
    netatalk

cp -fv ./etc/nsswitch.conf /etc/nsswitch.conf
adduser tm
chown -R tm /media/timemachine/
cp -fv ./etc/netatalk/AppleVolumes.default /etc/netatalk/AppleVolumes.default
