#!/bin/bash - 
#===============================================================================
#
#          FILE: qmount.sh
# 
#         USAGE: ./qmount.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 05/07/2016 12:01
#      REVISION:  ---
#===============================================================================

#if [ -z "$1" ] || [ ! -f "$1" ];
#then
#  echo -e "${red}Please provide the full path to qcow2 file... ${NC}"
#  exit 1
#fi
nbdDevice=$(~/loadrc/bashrc/find-free-nbd-device.sh)
echo "$nbdDevice" 
#qcow2File="$1"
#modprobe nbd max_part=8
#qemu-nbd --connect=/dev/nbd0 "$qcow2File"
