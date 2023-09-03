#!/usr/bin/env python3

# folder_content_migrator.py
# A script to move the contents of one folder into another while maintaining the tree structure.
# It moves the content efficiently using 'shutil.move' if the source and target folders are on the same partition, and 'rsync' for the rest.

import os
import sys
import shutil
from subprocess import call
from pathlib import Path


def same_partition(source_folder, target_folder):
    print(f"Checking if {source_folder} and {target_folder} are on the same partition...")
    return os.stat(source_folder).st_dev == os.stat(target_folder).st_dev


def move_folders(source_folder, target_folder):
    print(f"Moving contents from {source_folder} to {target_folder}...")
    if os.path.isdir(source_folder):
        if not os.path.isdir(target_folder):
            print(f"Target folder {target_folder} does not exist. Creating it...")
            os.makedirs(target_folder, exist_ok=True)

        if same_partition(source_folder, target_folder):
            print("Source and target folders are on the same partition. Using 'shutil.move'...")
            for root, _, files in os.walk(source_folder):
                for file in files:
                    src = os.path.join(root, file)
                    tgt = os.path.join(
                        target_folder, os.path.relpath(src, source_folder)
                    )
                    try:
                        print(f"Creating directories for {tgt} if they don't exist...")
                        os.makedirs(os.path.dirname(tgt), exist_ok=True)
                        print(f"Moving {src} to {tgt}...")
                        shutil.move(src, tgt) if not os.path.exists(
                            tgt
                        ) else print(
                            "Target file already exists, not overwriting."
                        )
                    except OSError as e:
                        print(f"Cannot create directory {os.path.dirname(tgt)}: {e}")

        # Call the rsync_folder_operations script
        print("Source and target folders are on different partitions. Using 'rsync'...")
        rsync_script_path = os.path.join(os.path.expanduser('~'), "loadrc/pythonrc/rsync_folder_operations.py")
        call(
            [
                rsync_script_path,
                source_folder,
                target_folder,
                "move",
            ]
        )

        # Remove empty directories after the move
        print("Removing empty directories...")
        for root, dirs, _ in os.walk(source_folder, topdown=False):
            for directory in dirs:
                dir_path = os.path.join(root, directory)
                if os.path.isdir(dir_path) and not os.listdir(dir_path):
                    print(f"Removing empty directory {dir_path}...")
                    os.rmdir(dir_path)

        # Check if source_folder is empty and remove it
        if not os.listdir(source_folder):
            print(f"Removing empty source folder {source_folder}...")
            os.rmdir(source_folder)
    else:
        print("Source folder does not exist. Exiting...")


def main():
    if len(sys.argv) != 3:
        print("Usage: {} source_folder target_folder".format(sys.argv[0]))
        sys.exit(1)

    source_folder = os.path.abspath(sys.argv[1])
    target_folder = os.path.abspath(sys.argv[2])
    move_folders(source_folder, target_folder)


if __name__ == "__main__":
    main()
