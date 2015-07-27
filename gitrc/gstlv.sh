#!/bin/bash
red='\033[0;31m'
green='\033[0;32m'
NC='\033[0;0m' # No Color
total=$(( `git stash list|wc -l` - 1 ))
echo -e "${green}total --> ${total} ${NC}"
for ((index=0 ; index < $total ; index++))
do
  echo -e "${green}current index --> ${index} ${NC}"
  $HOME/loadrc/gitrc/gstv.sh ${index}
done
