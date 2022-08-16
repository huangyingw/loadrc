#!/bin/zsh

parallel --jobs 0 -k ::: \
    ~/loadrc/bashrc/deploy_forward.sh \
    ~/loadrc/bashrc/deploy_backward.sh
