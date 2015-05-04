#!/bin/bash
SOURCE=$1
TARGET=$2

if [ ! -d "${TARGET}" ];
then
  mkdir -p "${TARGET}"
fi

rsync -aH --delete-before \
  --exclude fstab \
  --exclude grub.cfg \
  --exclude mdadm.conf \
  --exclude /boot/initrd.img-* \
  --exclude /boot/vmlinuz-* \
  --exclude /boot/grub \
  --exclude /var/lib/mldonkey/temp/ \
  --exclude 70-persistent-net.rules \
  --exclude interfaces \
  --exclude /etc/initramfs-tools/conf.d/resume \
  "${SOURCE}" "${TARGET}"
