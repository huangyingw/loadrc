#!/bin/zsh

~/loadrc/bashrc/generate_files_proj.sh &
~/loadrc/bashrc/generate_rsync_files.sh &
~/loadrc/bashrc/fvideos.sh &
~/loadrc/bashrc/fdocs.sh &
~/loadrc/bashrc/cscope.sh &
git remote update &
