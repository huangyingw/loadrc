#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

curl -fsSL https://raw.githubusercontent.com/fishworks/gofish/main/scripts/install.sh | bash
gofish init
gofish install gofish
gofish upgrade gofish
