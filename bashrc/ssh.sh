#! /bin/bash
~/loadrc/bashrc/smount.sh "$1"
OS=`uname`
if [ "$OS" == "Linux" ]
then
  autossh -X "$1" -t -- ${tmuxAction}
else
  ssh -X "$1" -t -- ${tmuxAction}
fi
