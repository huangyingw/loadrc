#!/bin/zsh

# Script Name: copy.sh

# Check if both source and target parameters are provided
if [ -z "$1" ] || [ -z "$2" ]; then
    echo -e "${red}Please provide both source and target parameters... ${NC}"
    exit 1
fi

source="$1"
target="$2"

# Call the rsync_folder_operations.zsh script with source, target, and the mode set to 'copy'
~/loadrc/zshrc/rsync_folder_operations.zsh "$source" "$target" "copy"
