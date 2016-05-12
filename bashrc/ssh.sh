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
    echo ssh -X "$user"@"$host" -t -- ${tmuxAction}
  else
    echo ssh -X -i "$key" "$user"@"$host" -t -- ${tmuxAction}
  fi
fi
