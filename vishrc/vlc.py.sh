#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

./vlc.py "/Users/huangyingw/Dropbox/learning/AI/fast.ai/Intro_to_Machine_Learning_-_Lesson_1.en.vtt" "02:11:12.620 --> 02:11:17.560"
./vlc.py "/Users/huangyingw/Dropbox/learning/AI/fast.ai/fav.log" "Machine_Learning_1_-_Lesson_8.mkv"
