"""
test_rsync_folder_operations.py
A script to test the functionality of rsync_folder_operations.py by creating sample folders and files and testing different modes.
"""

import os
import shutil
from unittest import TestCase, main as unittest_main
from rsync_folder_operations import rsync_operations


def create_sample_folders(base_folder):
    os.makedirs(os.path.join(base_folder, "source_folder/subfolder1"))
    os.makedirs(os.path.join(base_folder, "source_folder/subfolder2"))
    os.makedirs(os.path.join(base_folder, "target_folder"))

    with open(os.path.join(base_folder, "source_folder/file1.txt"), "w") as f:
        f.write("This is file1 in source_folder.")

    with open(
        os.path.join(base_folder, "source_folder/subfolder1/file2.txt"), "w"
    ) as f:
        f.write("This is file2 in subfolder1 of source_folder.")

    with open(
        os.path.join(base_folder, "source_folder/subfolder2/file3.txt"), "w"
    ) as f:
        f.write("This is file3 in subfolder2 of source_folder.")


def cleanup_sample_folders(base_folder):
    shutil.rmtree(os.path.join(base_folder, "source_folder"))
    shutil.rmtree(os.path.join(base_folder, "target_folder"))


class TestRsyncFolderOperations(TestCase):
    def setUp(self):
        self.base_folder = "test_folders"
        create_sample_folders(self.base_folder)
        self.source_folder = os.path.join(self.base_folder, "source_folder")
        self.target_folder = os.path.join(self.base_folder, "target_folder")

    def tearDown(self):
        cleanup_sample_folders(self.base_folder)

    def test_rsync_move(self):
        print("\nTesting mode: move")
        rsync_operations(self.source_folder, self.target_folder, "move")
        # Add assertions for the move mode here.

    def test_rsync_copy(self):
        print("\nTesting mode: copy")
        rsync_operations(self.source_folder, self.target_folder, "copy")
        # Add assertions for the copy mode here.

    def test_rsync_mirror(self):
        print("\nTesting mode: mirror")
        rsync_operations(self.source_folder, self.target_folder, "mirror")
        # Add assertions for the mirror mode here.

    def test_rsync_tmirror(self):
        print("\nTesting mode: tmirror")
        rsync_operations(self.source_folder, self.target_folder, "tmirror")
        # Add assertions for the tmirror mode here.


if __name__ == "__main__":
    unittest_main()
