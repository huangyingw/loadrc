#!/bin/zsh
scriptToRun="sh "$(realpath "$1")" 2>&1 | tee vcommand.findresult"
eval "$scriptToRun"
