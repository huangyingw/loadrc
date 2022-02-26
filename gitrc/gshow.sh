#!/bin/zsh
git show -w "$1" | sed "s/^--- a\//--- \.\//g;s/^+++ b\//+++ \.\//g"
