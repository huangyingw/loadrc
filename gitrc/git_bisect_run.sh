#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

git bisect start HEAD v1.2 --      # HEAD is bad, v1.2 is good
git bisect run make                # "make" builds the app
git bisect reset                   # quit the bisect session
