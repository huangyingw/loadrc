#!/bin/zsh
DOMAIN=$1
SNAPSHOT=$2
virsh destroy "$DOMAIN" \
  ; virsh snapshot-delete "$DOMAIN" "$SNAPSHOT" \
  && virsh start "$DOMAIN" \
  && virsh snapshot-list --tree "$DOMAIN"
