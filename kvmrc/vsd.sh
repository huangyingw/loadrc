#!/bin/bash
XMLFILE=$1
DOMAIN=$(python ~/loadrc/kvmrc/vsd.py $1)
virsh destroy "$DOMAIN" \
  ; virsh define "$XMLFILE" \
  ; virsh start "$DOMAIN" 
