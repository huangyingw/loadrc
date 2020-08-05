#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

./vlc.py "/Users/huangyingw/Dropbox/learning/AI/fast.ai" "02:11:12.620 --> 02:11:17.560"
