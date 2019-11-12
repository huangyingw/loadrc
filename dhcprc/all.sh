#!/bin/bash - 
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

./install.sh
./config.sh
./restart.sh
