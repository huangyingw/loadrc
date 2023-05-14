"""
test_rsync_folder_operations.py
A script to test the functionality of rsync_folder_operations.py by creating sample folders and files and testing different modes.
"""

import os
import shutil
from rsync_folder_operations import rsync_operations


def create_sample_folders(base_folder):
    os.makedirs(os.path.join(base_folder, "source_folder/subfolder1"))
    os.makedirs(os.path.join(base_folder, "source_folder/subfolder2"))
    os.makedirs(os.path.join(base_folder, "target_folder"))

    with open(os.path.join(base_folder, "source_folder/file1.txt"), "w") as f:
        f.write("This is file1 in source_folder.")

    with open(os.path.join(base_folder, "source_folder/subfolder1/file2.txt"), "w") as f:
        f.write("This is file2 in subfolder1 of source_folder.")

    with open(os.path.join(base_folder, "source_folder/subfolder2/file3.txt"), "w") as f:
        f.write("This is file3 in subfolder2 of source_folder.")


def cleanup_sample_folders(base_folder):
    shutil.rmtree(os.path.join(base_folder, "source_folder"))
    shutil.rmtree(os.path.join(base_folder, "target_folder"))


def test_rsync_operations():
    base_folder = "test_folders"

    create_sample_folders(base_folder)

    source_folder = os.path.join(base_folder, "source_folder")
    target_folder = os.path.join(base_folder, "target_folder")

    # Test different modes
    modes = ["move", "copy", "mirror", "tmirror"]
    for mode in modes:
        print(f"\nTesting mode: {mode}")
        rsync_operations(source_folder, target_folder, mode)

    # Clean up the sample folders
    cleanup_sample_folders(base_folder)


if __name__ == "__main__":
    test_rsync_operations()
