#!/bin/zsh
tmutil listlocalsnapshots / | grep -oE '\w{4}-\w{2}-[0-9]{2}-[0-9]{6}' | while read ss; do sudo tmutil deletelocalsnapshots "$ss"; done
