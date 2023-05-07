#!/bin/zsh

# Check if the SOURCE is provided, otherwise exit with an error message
if [ -z "$1" ]; then
    echo -e "${red}Please provide the SOURCE... ${NC}"
    exit 1
fi

# Check if the TARGET is provided, otherwise exit with an error message
if [ -z "$2" ]; then
    echo -e "${red}Please provide the TARGET... ${NC}"
    exit 1
fi

SOURCE="$1"
TARGET="$2"

# Check if the TARGET is a symbolic link and resolve the actual path
if [ -L "$TARGET" ]; then
    TARGET="$(readlink -f "$TARGET")"
fi

# If the real target is the same as the source, exit with an error message
if [ "$SOURCE" = "$TARGET" ]; then
    echo -e "${red}The real TARGET is the same as the SOURCE. Aborting...${NC}"
    exit 1
fi

# Find all files in the SOURCE directory
find "$SOURCE" -type f | \
    while read ss; do
        # Replace the SOURCE path with the TARGET path in the file's path
        new_ss=$(echo "$ss" | sed -e "s#$SOURCE#$TARGET#g")

        # Create the target directory if it doesn't exist
        mkdir -p "$(dirname "$new_ss")"

        # Move the file to the new location
        mv -nv "$ss" "$new_ss"
    done

# Call move.sh with the updated SOURCE and TARGET
~/loadrc/bashrc/move.sh "$SOURCE" "$TARGET"
