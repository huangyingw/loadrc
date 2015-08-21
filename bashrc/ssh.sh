#! /bin/bash
OS=`uname`
if [ "$OS" == "Linux" ]
then
  autossh -X "$1" -t -- 'tmux new-session -A -s main'
else
  ssh -X "$1" -t -- 'tmux new-session -A -s main'
fi
