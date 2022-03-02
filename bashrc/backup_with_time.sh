#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

source="$1"
dt=$(date '+%d_%m_%Y_%H_%M_%S');
target="${source}.$dt"
echo "target --> $target"

rsync -aHv --progress --delete-after \
    "${source}" "${target}"
