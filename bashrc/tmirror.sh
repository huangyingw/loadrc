#!/bin/zsh

# Script Name: tmirror.sh

source=$1
target=$2

# Call the rsync_folder_operations.zsh script with source, target, and mode set to 'tmirror'
~/loadrc/zshrc/rsync_folder_operations.zsh "$source" "$target" "tmirror"
