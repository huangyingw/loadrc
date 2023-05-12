#!/bin/zsh

# Script Name: move.sh

# Check if both source and target parameters are provided
if [ -z "$1" ] || [ -z "$2" ]; then
    echo -e "${red}Please provide both source and target parameters... ${NC}"
    exit 1
fi

# Get the real paths for source and target
source="$1"
realpath "$1" && source=$(realpath "$1")

target="$2"
realpath "$2" && target=$(realpath "$2")

# Only proceed if source and target are not the same
if [ -n "$source" ] && [ -n "$target" ] && [ "$source" != "$target" ]; then
    # Get necessary parameters for rsync
    iconvs=$(~/loadrc/bashrc/get_iconvs.sh "$source" "$target")
    rsyncpath=$(~/loadrc/bashrc/get_rsyncpath.sh "$source" "$target")
    rsync_basic_options=($(< ~/loadrc/bashrc/rsync_basic_options))

    # Perform rsync with appropriate options
    rsync \
        --remove-source-files \
        "${rsync_basic_options[@]}" \
        "$iconvs" \
        "$rsyncpath" \
        "$source/" "$target/"

    # Remove empty directories from the source
    ~/loadrc/bashrc/rmEmpty.sh "$source"
else
    # Print error message and exit if source and target are the same
    echo -e "${red}same dir --> ${source} ... ${NC}"
    echo -e "${red}please choose a different dir! ... ${NC}"
    exit 1
fi
