#!/bin/bash
git branch \
  |awk '/^\*/{print $2}' \
  && git checkout "$1" \
  && $HOME/loadrc/bashrc/cscope.sh
