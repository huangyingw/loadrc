#!/bin/bash
DOMAIN=$1
$HOME/loadrc/kvmrc/vrestore.sh "$DOMAIN" \
  ;virsh start "$DOMAIN"
