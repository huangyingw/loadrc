#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

./parse_host.sh "mini:~/loadrc"
./parse_host.sh "huangyingw@mini:~/loadrc"
./parse_host.sh "~/loadrc"
