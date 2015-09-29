#! /bin/bash
OS=`uname`
if [ "$OS" == "Linux" ]
then
  autossh -X "$1" -t -- 'tmux new-session -A -s main'
else
  if [ `hostname` == "MacPro" ]
  then
    ssh -X root@"$1" -t -- 'tmux attach'
  else
    ssh -X "$1" -t -- 'tmux attach'
  fi
fi
