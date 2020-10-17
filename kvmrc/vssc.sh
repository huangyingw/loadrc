#!/bin/zsh
DOMAIN=$1
SNAPSHOT=$2
virsh snapshot-create-as "$DOMAIN" "$SNAPSHOT" \
  && virsh snapshot-list --tree "$DOMAIN"
