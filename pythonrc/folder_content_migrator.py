#!/usr/bin/env python3

# folder_content_migrator.py
# A script to move the contents of one folder into another while maintaining the tree structure.
# It moves the content efficiently using 'shutil.move' if the source and target folders are on the same partition, and 'rsync' for the rest.

import os
import sys
import shutil
from subprocess import call
import subprocess
from pathlib import Path


# Check if the folder is a remote folder
def is_remote_folder(folder):
    return ":" in folder  # Updated condition


# Check if the source and target folders are on the same partition
def same_partition(source_folder, target_folder):
    print(
        f"Checking if {source_folder} and {target_folder} are on the same partition..."
    )

    if is_remote_folder(source_folder) or is_remote_folder(target_folder):
        print("One or both folders are remote. Cannot check partition.")
        return False
    try:
        return os.stat(source_folder).st_dev == os.stat(target_folder).st_dev
    except FileNotFoundError as e:
        print(f"Error: {e}")
        return False


# Remove empty directories using shell commands
def remove_empty_dirs_with_shell(target_folder):
    print(
        f"Efficiently removing empty directories in {target_folder} using shell commands..."
    )
    subprocess.run(["find", target_folder, "-type", "d", "-empty", "-delete"])
    subprocess.run(["rmdir", target_folder])


def move_folders(source_folder, target_folder):
    print(f"Moving contents from {source_folder} to {target_folder}...")
    if not os.path.isdir(target_folder):
        print(f"Target folder {target_folder} does not exist. Creating it...")
        os.makedirs(target_folder, exist_ok=True)

    if same_partition(source_folder, target_folder):
        print(
            "Source and target folders are on the same partition. Using 'shutil.move'..."
        )
        for root, _, files in os.walk(source_folder):
            for file in files:
                src = os.path.join(root, file)
                tgt = os.path.join(
                    target_folder, os.path.relpath(src, source_folder)
                )
                try:
                    print(
                        f"Creating directories for {tgt} if they don't exist..."
                    )
                    os.makedirs(os.path.dirname(tgt), exist_ok=True)
                    print(f"Moving {src} to {tgt}...")
                    shutil.move(src, tgt) if not os.path.exists(
                        tgt
                    ) else print(
                        "Target file already exists, not overwriting."
                    )
                except OSError as e:
                    print(
                        f"Cannot create directory {os.path.dirname(tgt)}: {e}"
                    )

    rsync_script_path = os.path.join(
        os.path.expanduser("~"),
        "loadrc/pythonrc/rsync_folder_operations.py",
    )
    call([rsync_script_path, source_folder, target_folder, "move"])

    # Remove empty directories after the move
    remove_empty_dirs_with_shell(source_folder)

    # Check if source_folder is empty and remove it
    if is_remote_folder(source_folder):
        print("Source folder is remote, skipping directory removal.")
    else:
        try:
            if not os.listdir(source_folder):
                print(f"Removing empty source folder {source_folder}...")
                os.rmdir(source_folder)
        except FileNotFoundError as e:
            print(f"Error: {e}")


def main():
    if len(sys.argv) != 3:
        print(f"Usage: {sys.argv[0]} source_folder target_folder")
        sys.exit(1)

    raw_source_folder = sys.argv[1]
    raw_target_folder = sys.argv[2]

    # Handle special/remote paths for source_folder
    source_folder = (
        raw_source_folder
        if ":" in raw_source_folder
        else os.path.abspath(raw_source_folder)
    )

    # Handle special/remote paths for target_folder
    target_folder = (
        raw_target_folder
        if ":" in raw_target_folder
        else os.path.abspath(raw_target_folder)
    )

    move_folders(source_folder, target_folder)


if __name__ == "__main__":
    main()
