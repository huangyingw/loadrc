#!/bin/bash
if [ -z "$1" ];
then
  echo "Please provide parameter"
  exit 1
fi
cryptsetup -h sha256 -c aes-cbc-essiv:sha256 -s 256 luksFormat "$1"
