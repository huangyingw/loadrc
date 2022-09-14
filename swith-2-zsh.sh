#!/bin/zsh

ZSH=$(which zsh)

if [ "$ZSH" != "$SHELL" ]
then
    sudo chsh -s "$ZSH"
    sudo reboot
fi
