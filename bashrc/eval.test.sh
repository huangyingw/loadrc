#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

TARGET=mini
COMMAND="ping $TARGET &"
eval "$COMMAND"

TARGET=server
COMMAND="ping $TARGET &"
eval "$COMMAND"
