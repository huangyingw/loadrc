#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

. .loadrc
dpkg -i $SOFTWARE/nx/nomachine_*.deb
