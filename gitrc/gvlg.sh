#!/bin/bash -
COMMIT="$1"
git difftool "$COMMIT"^!
