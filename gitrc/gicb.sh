#!/bin/bash

git init \
    && $HOME/loadrc/gitrc/gcob.sh dev.fix \
    ; $HOME/loadrc/gitrc/gdev.sh \
    && $HOME/loadrc/bashrc/cscope.sh \
    && $HOME/loadrc/gitrc/gci.sh n
