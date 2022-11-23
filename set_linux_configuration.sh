#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

if [ $(uname) != "Linux" ]
then
    exit 0
fi

find linux_links/ -type f | while read ss; \
do \
    sudo ~/loadrc/bashrc/ln_fs.sh "$ss" "/$(echo "$ss" | sed "s/linux_links\///g")"; \
done

find linux/ -type f | while read ss; \
do \
    sudo cp -fv --remove-destination "$ss" "/$(echo "$ss" | sed "s/linux\///g")"; \
done

sudo grub-mkconfig -o /boot/grub/grub.cfg
gsettings set org.gnome.desktop.lockdown disable-lock-screen 'true'
