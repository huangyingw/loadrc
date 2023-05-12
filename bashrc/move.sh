#!/bin/zsh

# Script Name: move.sh
# Description: This script is designed to move files and directories from a source location to a target location.
# It uses the rsync_content_migrator.zsh script to perform the move operation.

# Get the real paths for source and target
source="$1"
target="$2"

# Call the rsync_content_migrator.zsh script with source and target
~/loadrc/zshrc/rsync_content_migrator.zsh "$source" "$target"

# Remove empty directories from the source
~/loadrc/bashrc/rmEmpty.sh "$source"
