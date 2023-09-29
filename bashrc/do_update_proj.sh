#!/bin/zsh

parallel --jobs 10 -k ::: \
    ~/loadrc/bashrc/generate_file_index.sh \
    ~/loadrc/bashrc/generate_rsync_files.sh \
    ~/loadrc/bashrc/cscope.sh \
    ~/loadrc/bashrc/find_large_files_with_exclusions.sh \
    'git remote update'
