#!/bin/bash
fusermount -u /media/samba/ \
  ; sshfs server:/media/ /media/samba/ \
  && df -Th
