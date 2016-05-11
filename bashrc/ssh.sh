#! /bin/bash
OS=`uname`
if [ "$OS" == "Linux" ]
then
  autossh -X "$1" -t -- ${tmuxAction}
else
  SERVER="$1"
  if [[ $SERVER != *"@"* ]]
  then
    SERVER=root@"$SERVER"
  fi
  KEY=$(~/loadrc/keys/getKey.sh "$SERVER")

  if [ $KEY == "/Users/huangyingw/loadrc/keys/.pem" ];
  then
    ssh -X "$SERVER" -t -- ${tmuxAction}
  else
    ssh -X -i "$KEY" ubuntu@"$SERVER" -t -- ${tmuxAction}
  fi
fi
