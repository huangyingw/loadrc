#!/bin/zsh

# Script Name: move.sh

# Check if both source and target parameters are provided
if [ -z "$1" ] || [ -z "$2" ]; then
    echo -e "${red}Please provide both source and target parameters... ${NC}"
    exit 1
fi

source="$1"
target="$2"

# Call the rsync_folder_operations.py script with source, target, and the mode set to 'move'
~/loadrc/pythonrc/folder_content_migrator.py "$source" "$target"

# Remove empty directories from the source
~/loadrc/bashrc/rmEmpty.sh "$source"
