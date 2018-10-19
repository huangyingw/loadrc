#!/bin/bash -
find /media/volgrp/mirror/av/ -type f -name 6\*|while read ss; do dir=$(echo "$ss" | sed 's/\/mirror\//\/archive\//g'); mkdir -p "$(dirname "$dir")";mv -v "$ss" "$(dirname "$dir")"; done
find /media/volgrp/mirror/av/ -type f -name 7\*|while read ss; do dir=$(echo "$ss" | sed 's/\/mirror\//\/archive\//g'); mkdir -p "$(dirname "$dir")";mv -v "$ss" "$(dirname "$dir")"; done
