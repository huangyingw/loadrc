#!/bin/bash
git init \
  && $HOME/loadrc/gitrc/gcob.sh dev \
  && echo master > branch.default \
  && touch gci.default \
  && touch cscope.out \
  && touch gme.default \
  && $HOME/loadrc/bashrc/cscope.sh \
  && git add . \
  && $HOME/loadrc/gitrc/gci.sh
