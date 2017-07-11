#!/bin/bash
chmod 400 ~/.ssh/id_rsa
~/loadrc/gitrc/gpl.sh
if [ -f default.only ];
then
  git push -v default && git push -v --tag default
  exit 0
fi
for ss in `git remote -v |awk '/\(fetch\)$/{print $1}'`; do git push -v $ss && git push -v --tag $ss; done
