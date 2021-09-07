#!/bin/zsh
find /media/volgrp/mirror1/av/ -type f -size +100M -name 6\* | while read ss; do dir=$(echo "$ss" | sed 's/\/mirror1\//\/zarchive\//g'); mkdir -p "$(dirname "$dir")";mv -v "$ss" "$(dirname "$dir")"; done
find /media/volgrp/mirror1/av/ -type f -size +100M -name 7\* | while read ss; do dir=$(echo "$ss" | sed 's/\/mirror1\//\/zarchive\//g'); mkdir -p "$(dirname "$dir")";mv -v "$ss" "$(dirname "$dir")"; done
find /media/volgrp/mirror1/av/ -type f -size +100M -name 8\* | while read ss; do dir=$(echo "$ss" | sed 's/\/mirror1\//\/zarchive\//g'); mkdir -p "$(dirname "$dir")";mv -v "$ss" "$(dirname "$dir")"; done
