#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

if [ $(uname) != "Darwin" ]
then
    cp -v ~/.bashrc ~/.bashrc.bak
    cp -v ~/.profile ~/.profile.bak
    ln -fs ~/loadrc/.bashrc ~/.bashrc
    ln -fs ~/loadrc/.profile ~/.profile
fi

mv -fv ~/.config/git/gitk ~/.config/git/gitk.bak
ln -fs "$SCRIPTPATH" ~/loadrc
ln -fs ~/loadrc/."`hostname`".theanorc  ~/.theanorc
ln -fs ~/loadrc/.config/git/gitk  ~/.config/git/gitk
ln -fs ~/loadrc/.tmux.conf ~/.tmux.conf
ln -fs ~/loadrc/gitrc/.gitconfig ~/.gitconfig
ln -fs ~/loadrc/gitrc/.globalgitignore ~/.globalgitignore
ln -fs ~/loadrc/pythonrc/setup.cfg  ~/setup.cfg
ln -fs ~/loadrc/usr/NX/etc/node.cfg  /usr/NX/etc/node.cfg
ln -fs ~/loadrc/vimrc/.vim ~/.vim
ln -fs ~/loadrc/vimrc/.vimrc ~/.vimrc
mkdir -p ~/.config/nvim/
ln -fs ~/loadrc/.config/nvim/init.vim ~/.config/nvim/init.vim

./set_linux_configuration.sh
./set_host_configuration.sh
