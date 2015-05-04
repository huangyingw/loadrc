#!/bin/bash
red='\033[0;31m'
green='\033[0;32m'
NC='\033[0;0m' # No Color
DOMAIN=$1
SNAPSHOT=$2
if  ( virsh list|grep -q "$DOMAIN" )
then
  echo -e "${red} ${DOMAIN} is running, please shut it down before continuing... ${NC}"
  exit 1
fi 
virsh snapshot-create-as "$DOMAIN" "$SNAPSHOT" \
  && virsh start "$DOMAIN" \
  && virsh snapshot-list --tree "$DOMAIN"
