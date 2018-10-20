#!/bin/bash -
find /media/volgrp/mirror/av/ -type f -size +100M -name 6\* | while read ss; do dir=$(echo "$ss" | sed 's/\/mirror\//\/archive\//g'); mkdir -p "$(dirname "$dir")";mv -v "$ss" "$(dirname "$dir")"; done
find /media/volgrp/mirror/av/ -type f -size +100M -name 7\* | while read ss; do dir=$(echo "$ss" | sed 's/\/mirror\//\/archive\//g'); mkdir -p "$(dirname "$dir")";mv -v "$ss" "$(dirname "$dir")"; done
