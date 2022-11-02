#!/bin/zsh

parallel --jobs 10 -k ::: \
    ~/loadrc/bashrc/generate_files_proj.sh \
    ~/loadrc/bashrc/fvideos.sh \
    ~/loadrc/bashrc/fdocs.sh \
    ~/loadrc/bashrc/cscope.sh \
    'git remote update'
