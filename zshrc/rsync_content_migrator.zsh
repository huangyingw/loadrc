#!/bin/zsh

# rsync_content_migrator.zsh
# A script to move the contents of one folder into another using rsync while maintaining the tree structure.

rsync_move() {
    source_folder="$1"
    target_folder="$2"

    if [ "$(readlink -f "$source_folder")" = "$(readlink -f "$target_folder")" ]; then
        echo "Source and target folders are identical or just soft links to each other. Aborting."
        return 1
    fi

    rsync_basic_options=($(< ~/loadrc/bashrc/rsync_basic_options))
    rsync "${rsync_basic_options[@]}" \
            --remove-source-files \
            --info=progress2 \
            "$source_folder/" \
            "$target_folder/"
}

main() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Usage: $0 source_folder target_folder"
        exit 1
    fi

    source_folder="$1"
    target_folder="$2"
    rsync_move "$source_folder" "$target_folder"
}

# Call the main function with the provided arguments
main "$@"
