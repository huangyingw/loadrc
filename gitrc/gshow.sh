#!/bin/zsh
git show --minimal -w "$1" | sed "s/^--- a\//--- \.\//g;s/^+++ b\//+++ \.\//g"
