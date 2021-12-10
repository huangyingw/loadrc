#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

./get_iconv.sh "u2004:~/loadrc"
./get_iconv.sh "huangyingw@mbp:~/loadrc"
./get_iconv.sh "~/loadrc"
