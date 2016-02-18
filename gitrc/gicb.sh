#!/bin/bash
git init \
  && $HOME/loadrc/gitrc/gcob.sh dev \
  && touch gci.default \
  && touch gps.default \
  && touch gme.default \
  && $HOME/loadrc/bashrc/cscope.sh \
  && git add . \
  && $HOME/loadrc/gitrc/gci.sh
