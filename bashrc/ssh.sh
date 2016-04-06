#! /bin/bash
OS=`uname`
if [ "$OS" == "Linux" ]
then
  autossh -X "$1" -t -- 'tmux new-session -A -s main'
else
  SERVER="$1"
  KEY=$(~/loadrc/keys/getKey.sh "$SERVER")

  if [ $KEY == "/Users/huangyingw/loadrc/keys/.pem" ];
  then
    ssh -X root@"$SERVER" -t -- 'tmux new-session -A -s main'
  else
    ssh -X -i "$KEY" ubuntu@"$SERVER" -t -- 'tmux new-session -A -s main'
  fi
fi
