#!/bin/bash

git init \
    && $HOME/loadrc/gitrc/gcob.sh dev.fix \
    ; $HOME/loadrc/gitrc/gdev.sh \
    && $HOME/loadrc/bashrc/cscope.sh \
    && git add files.proj \
    && $HOME/loadrc/gitrc/gci.sh n
