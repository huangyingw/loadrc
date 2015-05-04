#! /bin/bash
/etc/init.d/mldonkey-server stop \
    && umount /media/mldonkey/ \
    && ~/loadrc/bashrc/sleep.sh
