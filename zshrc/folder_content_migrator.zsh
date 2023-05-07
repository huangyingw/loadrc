#!/bin/zsh

# folder_content_migrator.zsh
# A script to move the contents of one folder into another while maintaining the tree structure.
# It moves the content efficiently using 'mv' if the source and target folders are on the same partition, and 'rsync' for the rest.

move_folders() {
    source_folder="$1"
    target_folder="$2"

    if [ -d "$source_folder" ] && [ -d "$target_folder" ]; then
        if [[ "$(df -P "$source_folder" | tail -1 | awk '{print $1}')" == "$(df -P "$target_folder" | tail -1 | awk '{print $1}')" ]]; then
            # Use 'mv' if the source and target folders are on the same partition.
            find "$source_folder" \( -type f -o -type l \) -exec zsh -c 'src=$1; tgt="${src/#$2/$3}"; mkdir -p "$(dirname "$tgt")"; mv -v "$src" "$tgt"' zsh '{}' "$source_folder" "$target_folder" \;
            find "$source_folder" -type d -empty -delete
        else
            # Use 'rsync' for folders on different partitions.
            rsync -a --remove-source-files --info=progress2 "$source_folder/" "$target_folder/"
            find "$source_folder" -type d -empty -delete
        fi
    else
        echo "Source or target folder does not exist."
    fi
}

main() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Usage: $0 source_folder target_folder"
        exit 1
    fi

    source_folder="$1"
    target_folder="$2"
    move_folders "$source_folder" "$target_folder"
}

# Test code
source_folder="/media/sda1/home/huangyingw/Dropbox/myproject"
target_folder="/media/sda1/root/Dropbox/myproject"
echo "Moving contents from '$source_folder' to '$target_folder'"
main "$source_folder" "$target_folder"
