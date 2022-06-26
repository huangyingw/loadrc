#!/bin/zsh 
cscopes=($(find . -type f -name files.proj))
for cscope in "${cscopes[@]}"
do
  echo "${cscope}"
  ~/loadrc/bashrc/update_proj.sh $(dirname "${cscope}")
done
