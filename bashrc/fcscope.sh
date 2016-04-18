#!/bin/bash - 
cscopes=($(find . -type f -name cscope.out))
for cscope in "${cscopes[@]}"
do
  ~/loadrc/bashrc/cscope.sh $(dirname "${cscope}")
done
