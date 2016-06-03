#!/bin/bash
~/loadrc/gitrc/gpl.sh
if [ -f dropbox.only ];
then
  git push -v dropbox && git push -v --tag dropbox
  exit 0
fi
for ss in `git remote -v |awk '/\(fetch\)$/{print $1}'`; do git push -v $ss && git push -v --tag $ss; done
