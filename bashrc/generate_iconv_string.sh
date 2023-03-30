#!/bin/zsh

# Usage: generate_iconv_string.zsh <source_directory> <destination_directory>

source_directory="$1"
destination_directory="$2"

# Function to check if a directory is a remote path and detect the OS
check_remote_and_detect_os() {
    local directory="$1"
    local os=""

    if [[ $directory =~ ^[^:]+:[^:]+$ ]]; then
        # Extract user and host from the remote path
        local user_host="${directory%%:*}"
        os_info=$(ssh "$user_host" "uname")
        if [[ $os_info == "Darwin" ]]; then
            os="macOS"
        elif [[ $os_info == "Linux" ]]; then
            os="Linux"
        else
            echo "Unsupported operating system: $os_info"
            exit 1
        fi
    else
        os=$(uname)
        if [[ $os != "Darwin" ]] && [[ $os != "Linux" ]]; then
            echo "Unsupported operating system: $os"
            exit 1
        fi
    fi

    echo "$os"
}

# Detect the source and destination OS
source_os=$(check_remote_and_detect_os "$source_directory")
destination_os=$(check_remote_and_detect_os "$destination_directory")

if [ "$source_os" = "macOS" ] && [ "$destination_os" = "Linux" ]; then
    echo "--iconv=utf-8,utf-8-mac"
elif [ "$source_os" = "Linux" ] && [ "$destination_os" = "macOS" ]; then
    echo "--iconv=utf-8-mac,utf-8"
else
    echo ""
fi
