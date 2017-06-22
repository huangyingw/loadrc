#!/bin/bash - 
if ping -c 1 macpro &> /dev/null
then
  sshfs -o nonempty huangyingw@macpro:/Users/huangyingw/Dropbox/loadrc/ ~/loadrc/
  df -TH
  . $HOME/loadrc/.loadrc
else
  . $HOME/loadrc/.loadrc
fi
