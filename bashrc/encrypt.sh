#!/bin/zsh
if [ -z "$1" ]
then
    echo -e "${red}Please provide parameter ... ${NC}"
    exit 1
fi
cryptsetup -h sha256 -c aes-cbc-essiv:sha256 -s 256 luksFormat "$1"
cryptsetup luksAddKey "$1" /root/loadrc/keys/keyfile  
