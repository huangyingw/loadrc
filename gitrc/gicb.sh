#!/bin/bash
git init \
  && $HOME/loadrc/gitrc/gcob.sh dev.fix \
  && echo master > branch.default \
  && touch cscope.out \
  && touch dropbox.only \
  && touch gme.default \
  && $HOME/loadrc/bashrc/cscope.sh \
  && git add . \
  && $HOME/loadrc/gitrc/gci.sh
