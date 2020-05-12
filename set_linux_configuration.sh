#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

if [ $(uname) != "Linux" ]
then
    exit 0
fi

find linux/ -type f | while read ss; \
do \
    ~/loadrc/bashrc/ln_fs.sh "$ss" "/$(echo "$ss" | sed "s/linux\///g")"; \
done

grub-mkconfig -o /boot/grub/grub.cfg
gsettings set org.gnome.desktop.lockdown disable-lock-screen 'true'
