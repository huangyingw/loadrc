#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

#https://stackoverflow.com/questions/26983700/git-run-shell-command-for-each-commit
git rebase -i --exec <build command> <first sha you want to test>~
