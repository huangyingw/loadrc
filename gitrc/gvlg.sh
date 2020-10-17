#!/bin/zsh
COMMIT="$1"
git difftool -y "$COMMIT"^!
