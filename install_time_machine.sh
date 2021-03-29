#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

TARGET_DIR="/srv/netatalk/time-machine"
TARGET_DIR_FOR_SED=$(echo "$TARGET_DIR" | sed 's/\//\\\//g')
apt install -y netatalk avahi-daemon
cp -fv ./etc/netatalk/afp.conf /etc/netatalk/afp.conf
sed -i.bak "s/target_dir_var/$TARGET_DIR_FOR_SED/g" /etc/netatalk/afp.conf

mkdir -p "$TARGET_DIR"
chown nobody:nogroup "$TARGET_DIR"
chmod -R 777 "$TARGET_DIR"

service netatalk restart
