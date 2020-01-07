#!/bin/zsh
DOMAIN=$1

virsh snapshot-list --tree "$DOMAIN"
