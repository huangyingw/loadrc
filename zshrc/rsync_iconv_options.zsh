#!/bin/zsh

function get_remote_encoding() {
    remote_path="$1"
    remote_os="$(ssh -q -o BatchMode=yes -o StrictHostKeyChecking=no "${remote_path%%:*}" "uname")"
    if [[ "$remote_os" == "Darwin" ]]; then
        echo "utf-8-mac"
    else
        echo "utf-8"
    fi
}

function main() {
    # Check if the required parameters are provided
    if [ $# -ne 2 ]; then
        echo "Usage: $0 <source_directory> <destination_directory>"
        exit 1
    fi

    source_dir="$1"
    destination_dir="$2"

    # Detect the local operating system and set the appropriate encoding
    if [[ "$(uname)" == "Darwin" ]]; then
        local_encoding="utf-8-mac"
    else
        local_encoding="utf-8"
    fi

    # Check if the source directory is remote
    if [[ $source_dir =~ ^([^@]*@)?[^:]+: ]]; then
        src_encoding=$(get_remote_encoding "$source_dir")
    else
        src_encoding=$local_encoding
    fi

    # Check if the destination directory is remote
    if [[ $destination_dir =~ ^([^@]*@)?[^:]+: ]]; then
        dst_encoding=$(get_remote_encoding "$destination_dir")
    else
        dst_encoding=$local_encoding
    fi

    # Set the rsync options
    rsync_options="--iconv=$src_encoding,$dst_encoding"

    # Output the rsync options
    echo "$rsync_options"
}

main "$@"
#main ~/loadrc/ mini:~/loadrc/
#main mini:~/loadrc/ ~/loadrc/ 
#main ~/loadrc/ ~/loadrc/ 
#main mini:~/loadrc/ mini:~/loadrc/ 
