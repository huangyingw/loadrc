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
        rsync_options = rsync_operations(
            self.source_folder, self.target_folder, "move"
        )
        self.assertIn("--remove-source-files", rsync_options)
        self.assertNotIn("--delete-before", rsync_options)

    def test_rsync_copy(self):
        print("\nTesting mode: copy")
        rsync_options = rsync_operations(
            self.source_folder, self.target_folder, "copy"
        )
        self.assertNotIn("--remove-source-files", rsync_options)
        self.assertNotIn("--delete-before", rsync_options)
        self.assertNotIn("-in", rsync_options)

    def test_rsync_mirror(self):
        print("\nTesting mode: mirror")
        rsync_options = rsync_operations(
            self.source_folder, self.target_folder, "mirror"
        )
        self.assertNotIn("--remove-source-files", rsync_options)
        self.assertIn("--delete-before", rsync_options)
        self.assertNotIn("-in", rsync_options)

    def test_rsync_tmirror(self):
        print("\nTesting mode: tmirror")
        rsync_options = rsync_operations(
            self.source_folder, self.target_folder, "tmirror"
        )
        self.assertNotIn("--remove-source-files", rsync_options)
        self.assertIn("-in", rsync_options)
        self.assertIn("--delete-before", rsync_options)

    def test_rsync_same_source_and_target(self):
        print("\nTesting same source and target folders")
        with self.assertRaises(ValueError):
            rsync_operations(self.source_folder, self.source_folder, "move")

    def test_rsync_soft_link_target(self):
        print("\nTesting soft link target folders")
        soft_link_target = os.path.join(self.base_folder, "target_soft_link")
        try:
            os.remove(soft_link_target)
        except FileNotFoundError:
            pass
        os.symlink(os.path.abspath(self.source_folder), soft_link_target)

        with self.assertRaises(ValueError):
            rsync_operations(self.source_folder, soft_link_target, "move")

        os.remove(soft_link_target)

    def test_rsync_hard_link_target(self):
        print("\nTesting when target folder is a hard link to source folder")
        hard_link_target = os.path.join(self.base_folder, "target_hard_link")
        try:
            os.link(self.source_folder, hard_link_target)
        except OSError:
            print(
                "Note: The hard link test case is only valid for file systems that support hard links for directories."
            )
            return

        with self.assertRaises(ValueError):
            rsync_operations(self.source_folder, hard_link_target, "move")
        os.unlink(hard_link_target)


if __name__ == "__main__":
    unittest_main()
