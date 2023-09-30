#!/bin/zsh

parallel --jobs 10 -k ::: \
    ~/loadrc/bashrc/generate_file_index.sh \
    ~/loadrc/bashrc/generate_rsync_files.sh \
    ~/loadrc/bashrc/cscope.sh \
    'git remote update'
