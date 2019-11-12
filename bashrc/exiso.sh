#! /bin/bash
source=$1

umount -fl /media/cdrom
target="`echo "${source}" |sed  -e "s/\.iso$/\_iso/g;s/\.ISO$/\_iso/g"`"
mkdir -p "${target}"

mount "${source}" /media/cdrom -o loop \
  && rsync -vrlptDH --progress /media/cdrom/ "${target}" \
  && rm -fv "${source}"
