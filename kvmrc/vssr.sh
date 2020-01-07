#!/bin/zsh
DOMAIN=$1
SNAPSHOT=$2

virsh snapshot-revert --force "$DOMAIN" --snapshotname "$SNAPSHOT"
