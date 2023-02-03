#!/bin/zsh
cscopes=($(find . -type f -name files.proj))
for cscope in "${cscopes[@]}"
do
  echo "${cscope}"
  ~/loadrc/bashrc/do_update_proj.sh $(dirname "${cscope}")
done
