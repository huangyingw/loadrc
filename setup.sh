#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

OS=`uname`
apt-get install -y vim-gnome ssh tmux mosh git kdiff3 qemu-kvm libvirt-bin ubuntu-vm-builder bridge-utils curl net-tools sshfs
mv -fv ~/.config/git/gitk ~/.config/git/gitk.bak
ln -fs "$SCRIPTPATH" ~/loadrc
ln -fs ~/loadrc/.bashrc ~/.bashrc
ln -fs ~/loadrc/.tmux.conf ~/.tmux.conf
ln -fs ~/loadrc/gitrc/.gitconfig ~/.gitconfig
ln -fs ~/loadrc/gitrc/.globalgitignore ~/.globalgitignore
ln -fs ~/loadrc/vimrc/.vim ~/.vim
ln -fs ~/loadrc/vimrc/.vimrc ~/.vimrc
ln -fs ~/loadrc/.config/git/gitk  ~/.config/git/gitk
ln -fs ~/loadrc/pythonrc/setup.cfg  ~/setup.cfg
ln -fs ~/loadrc/.theanorc  ~/.theanorc
git submodule init
git submodule sync
git submodule update
git submodule foreach ~/loadrc/gitrc/gsync.sh
git submodule foreach ~/loadrc/gitrc/gps.sh

./macvim/build.sh
./vimrc/.vim/bundle/YouCompleteMe/install.sh
./bashrc/cscope.sh
./gitrc/gclean.sh
./kvmrc/install.sh
./dockerrc/install.sh
if [ $OS != "Darwin" ]
then
    curl -s https://install.zerotier.com/ | bash
    zerotier-cli join 93afae5963560e41
fi
