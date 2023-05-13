#!/bin/zsh

# decide_mkpath_option.zsh
# A script to determine if the --mkpath option should be used with rsync based on the version of rsync on both source and target systems.

get_rsync_version_command() {
    echo "rsync --version | head -n 1 | awk '{print \$3}'"
}

get_rsync_version() {
    host_info="$1"
    host=$(echo "$host_info" | cut -d ':' -f 1)
    cmd=$(get_rsync_version_command)

    if [ -z "$host" ] || [[ "$host_info" != *":"* ]]; then
        rsync_version=$(eval "$cmd")
    else
        rsync_version=$(ssh "$host" "$cmd")
    fi

    echo "$rsync_version"
}

check_rsync_version() {
    rsync_version="$1"

    if [[ $(echo "$rsync_version >= 3.2.0" | bc -l) -eq 1 ]]; then
        return 0
    else
        return 1
    fi
}

decide_mkpath_option() {
    source_folder="$1"
    target_folder="$2"

    source_rsync_version=$(get_rsync_version "$source_folder")
    target_rsync_version=$(get_rsync_version "$target_folder")

    if check_rsync_version "$source_rsync_version" && check_rsync_version "$target_rsync_version"; then
        echo "--mkpath"
    else
        echo ""
    fi
}

main() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Usage: $0 source_folder target_folder"
        exit 1
    fi

    source_folder="$1"
    target_folder="$2"
    mkpath_option=$(decide_mkpath_option "$source_folder" "$target_folder")
    echo "$mkpath_option"
}

# Call the main function with the provided arguments only when the script is not being sourced
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    main "$@"
fi
