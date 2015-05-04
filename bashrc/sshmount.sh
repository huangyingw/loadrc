#!/bin/bash
fusermount -u /media/samba/ \
  ; sshfs ubuntu:/media/ /media/samba/ \
  && df -Th
