#!/bin/bash
for file in `ls .`
do
  cd $file
  git init
  git add .
  git commit -am "n"
  $HOME/loadrc/gitrc/gclb.sh
  cd - 1>/dev/null
done
