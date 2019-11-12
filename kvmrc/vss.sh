#!/bin/zsh
~/loadrc/kvmrc/uvmount.sh
DOMAIN=$1
$HOME/loadrc/kvmrc/vrestore.sh "$DOMAIN" \
    ;virsh start "$DOMAIN"
