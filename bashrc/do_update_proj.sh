#!/bin/zsh
./generate_files_proj.sh &
./cscope.sh &
./generate_rsync_files.sh &
