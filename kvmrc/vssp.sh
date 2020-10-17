#!/bin/zsh
DOMAIN=$1
virsh snapshot-current --name "$DOMAIN"
