#! /bin/zsh
rsync -aH --force -e ssh --exclude=/media/volgrp/kvm/* /media/volgrp/ server:/media/volgrp/ \
  ; $HOME/loadrc/bashrc/rsleep.sh
