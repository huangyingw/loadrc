#!/bin/bash
DOMAIN=$1
SNAPSHOT=$2
$HOME/loadrc/kvmrc/vsuspend.sh \
  ; virsh destroy "$DOMAIN" \
  ; virsh snapshot-revert --force "$DOMAIN" --snapshotname "$SNAPSHOT" \
  && virsh start "$DOMAIN" \
  ; $HOME/loadrc/kvmrc/vresume.sh
