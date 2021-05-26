#!/bin/zsh

ZSH=$(which zsh)

if [ "$ZSH" != "$SHELL" ]
then
    chsh -s "$ZSH"
    reboot
fi
