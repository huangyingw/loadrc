#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder; say cache flushed

cd -
