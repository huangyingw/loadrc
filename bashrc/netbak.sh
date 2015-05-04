#! /bin/bash
rsync -aH --force -e ssh --exclude=/media/volgrp/kvm/* /media/volgrp/ ubuntu:/media/volgrp/ \
  ; $HOME/bashrc/rsleep.sh
