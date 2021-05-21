#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

cd ../
~/loadrc/gitrc/apply_branch.sh github/generate_files_proj
~/loadrc/gitrc/apply_branch.sh remotes/github/generate_files_proj
