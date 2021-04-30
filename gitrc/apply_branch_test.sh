#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

# ./apply_branch.sh  hypo
./apply_branch.sh remotes/github/generate_files_proj
# ./apply_branch.sh remotes/github/yhuang/RunShell
