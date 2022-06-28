#!/bin/zsh

parallel ::: \
    ~/loadrc/bashrc/deploy_forward.sh \
    ~/loadrc/bashrc/deploy_backward.sh
