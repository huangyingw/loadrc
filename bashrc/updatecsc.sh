#!/bin/bash
PROPERTIES=~/loadrc/bashrc/`hostname`.csc.properties
while read ss
do
  ~/loadrc/bashrc/cscope.sh "$ss"
done < "$PROPERTIES"
read -p "press any key to continue...." update
