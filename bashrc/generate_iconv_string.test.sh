#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

./generate_iconv_string.sh "/tmp" "/tmp" > /tmp/generate_iconv_string.test.sh.out
./generate_iconv_string.sh "mini:/root/" "/tmp" > /tmp/generate_iconv_string.test.sh.out
