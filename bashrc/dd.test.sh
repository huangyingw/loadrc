#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

./dd.sh /media/psf/Home/software/tinypilot-voyager-2.3.2-2022-01-10T1531Z.img /dev/sdc
