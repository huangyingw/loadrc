#!/bin/zsh
DOMAIN=$1
SNAPSHOT=$2
~/loadrc/kvmrc/vssd.sh "$DOMAIN" "$SNAPSHOT"
~/loadrc/kvmrc/vssc.sh "$DOMAIN" "$SNAPSHOT"
