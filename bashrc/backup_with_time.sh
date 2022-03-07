#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

source="$1"
dt=$(date '+%m_%d_%Y_%H_%M_%S');
target="${source}.$dt"
echo "target --> $target"

rsync -aHv --delete-after \
    "${source}/" "${target}/"
