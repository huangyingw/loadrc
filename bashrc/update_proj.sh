#!/bin/zsh -

start=$(date +%s)
~/loadrc/bashrc/check_running.sh ~/loadrc/bashrc/cscope.sh
(( elapsed = $(date +%s) - $start ))
echo $elapsed > running.time
