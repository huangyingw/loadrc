#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

./generate_iconv_string.sh "/tmp" "/tmp"
./generate_iconv_string.sh "mini:/root/" "/tmp"
./generate_iconv_string.sh "/tmp" "mini:/root/"
