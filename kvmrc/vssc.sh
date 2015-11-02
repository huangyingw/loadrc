#!/bin/bash
red='\033[0;31m'
green='\033[0;32m'
NC='\033[0;0m' # No Color
DOMAIN=$1
SNAPSHOT=$2
virsh snapshot-create-as "$DOMAIN" "$SNAPSHOT" \
  && virsh snapshot-list --tree "$DOMAIN"
