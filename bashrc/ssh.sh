#! /bin/bash
OS=`uname`
if [ "$OS" == "Linux" ]
then
  autossh -X "$1" -t -- ${tmuxAction}
else
  SERVER="$1"
  . ~/loadrc/keys/getConDetails.sh "$SERVER"

  if [ $key == "/Users/huangyingw/loadrc/keys/.pem" ];
  then
    ssh -X "$user"@"$host" -t -- ${tmuxAction}
  else
    ssh -X -i "$key" "$user"@"$host" -t -- ${tmuxAction}
  fi
fi
