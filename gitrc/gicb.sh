#!/bin/bash
git init \
  && $HOME/loadrc/gitrc/gcob.sh dev \
  && git config branches.sync master \
  && touch gci.default \
  && touch cscope.out \
  && touch gme.default \
  && $HOME/loadrc/bashrc/cscope.sh \
  && git add . \
  && $HOME/loadrc/gitrc/gci.sh
