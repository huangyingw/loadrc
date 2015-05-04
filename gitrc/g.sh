#!/bin/bash
red='\033[0;31m'
green='\033[0;32m'
NC='\033[0;0m' # No Color

~/loadrc/gitrc/gps.sh
commit_message='n'
if [ -n "$1" ];
then
  commit_message="$1"
fi
git commit  --no-verify -m "$commit_message"
~/loadrc/gitrc/gps.sh
