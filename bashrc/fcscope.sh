#!/bin/bash - 
cscopes=($(find . -type f -name cscope.out))
for cscope in "${cscopes[@]}"
do
  echo "${cscope}"
  ~/loadrc/bashrc/cscope.sh $(dirname "${cscope}")
done
