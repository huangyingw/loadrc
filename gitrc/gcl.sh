#!/bin/bash

if [ -z "$1" ];
then
  echo -e "${red}Please provide parameter ... ${NC}"
  exit 1
fi

if [[ "$1" == *"Dropbox"* ]]
then
  target=`echo $1 | sed -e "s|Dropbox/||"`
  echo ${target}
  git clone "$1" "$target" \
    && cd ${target} \
    && $HOME/loadrc/bashrc/cscope.sh
else
  target=`echo $1 | sed -e "s|.git$||;s|^.*\/||"` \
    && echo ${target} \
    && git clone "$1" \
    && cd ${target} \
    && $HOME/loadrc/gitrc/gcob.sh dev \
    && echo master > branch.default \
    && touch gci.default \
    && touch cscope.out \
    && touch gme.default \
    && $HOME/loadrc/bashrc/cscope.sh \
    && git add . \
    && $HOME/loadrc/gitrc/gci.sh
fi
