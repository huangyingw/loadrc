#!/bin/bash -
git branch -a | grep remotes/.*"$branch"$ | head -1 |  sed -e 's/^[ \t]*//'
