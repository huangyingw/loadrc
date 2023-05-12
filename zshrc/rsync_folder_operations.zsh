#!/bin/zsh

# rsync_folder_operations.zsh
# A script to move, copy, or mirror the contents of one folder into another using rsync while maintaining the tree structure.

rsync_operations() {
    source_folder="$1"
    target_folder="$2"
    mode="$3"

    # Get the real paths for source and target
    realpath "$source_folder" && source_folder=$(realpath "$source_folder")
    realpath "$target_folder" && target_folder=$(realpath "$target_folder")

    if [ "$(readlink -f "$source_folder")" = "$(readlink -f "$target_folder")" ]; then
        echo "Source and target folders are identical or just soft links to each other. Aborting."
        return 1
    fi

    # Get necessary parameters for rsync
    iconvs=$(~/loadrc/bashrc/get_iconvs.sh "$source_folder" "$target_folder")
    rsyncpath=$(~/loadrc/bashrc/get_rsyncpath.sh "$source_folder" "$target_folder")
    rsync_basic_options=($(< ~/loadrc/bashrc/rsync_basic_options))

    # Set rsync options based on the mode (move, copy, mirror, or tmirror)
    rsync_options=("${rsync_basic_options[@]}" "$iconvs" "$rsyncpath")
    if [ "$mode" = "move" ]; then
        rsync_options+=("--remove-source-files")
    elif [ "$mode" = "mirror" ]; then
        rsync_options+=("--delete-before")
    elif [ "$mode" = "tmirror" ]; then
        rsync_options+=("-in" "--delete-before")
    fi

    # Perform rsync with --mkpath option first
    if ! rsync "${rsync_options[@]}" --mkpath "$source_folder/" "$target_folder/"; then
        # If rsync with --mkpath option fails, try again without the option
        rsync "${rsync_options[@]}" "$source_folder/" "$target_folder/"
    fi
}

main() {
    if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
        echo "Usage: $0 source_folder target_folder mode"
        echo "mode: 'move', 'copy', or 'mirror'"
        exit 1
    fi

    source_folder="$1"
    target_folder="$2"
    mode="$3"
    rsync_operations "$source_folder" "$target_folder" "$mode"
}

# Call the main function with the provided arguments
main "$@"
