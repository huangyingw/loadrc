#!/bin/zsh

mkdir -p ~/.local/share/shotwell/data/
ln -fs /media/psf/Dropbox/.local/share/shotwell/data/photo.db ~/.local/share/shotwell/data/photo.db
ln -fs /media/psf/Dropbox/.config/smplayer ~/.config/smplayer
apt-get purge -y totem totem-plugins
apt-get install -y \
    ibus-table \
    ibus-table-wubi \
    mosh \
    mplayer \
    realpath  \
    smplayer \
    ssh \
    sshfs \
    tmux \
    vim-gnome
