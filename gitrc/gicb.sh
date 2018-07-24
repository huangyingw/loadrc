#!/bin/bash

git init \
    && $HOME/loadrc/gitrc/gcob.sh dev \
    ; $HOME/loadrc/gitrc/gdev.sh \
    && $HOME/loadrc/bashrc/update_proj.sh \
    && git add . \
    && $HOME/loadrc/gitrc/g.sh n
