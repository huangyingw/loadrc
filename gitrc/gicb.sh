#!/bin/bash
git init \
  && $HOME/loadrc/gitrc/gcob.sh dev.fix \
  && $HOME/loadrc/gitrc/gdev.sh \
  && $HOME/loadrc/bashrc/cscope.sh \
  && git add . \
  && $HOME/loadrc/gitrc/gci.sh n
