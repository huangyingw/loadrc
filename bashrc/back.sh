#! /bin/bash
SOURCE=$1
TARGET=$2

if [ ! -d "${TARGET}" ];
then   
  mkdir -p "${TARGET}"
fi

rsync -aH --delete-after \
  --exclude=/proc \
  --exclude=/etc/fstab \
  --exclude=/boot/grub/grub.cfg \
  --exclude=/lost+found \
  --exclude=/media \
  --exclude=/sys \
  --include=myproject \
  "${SOURCE}" "${TARGET}"
