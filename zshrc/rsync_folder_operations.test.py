#!/usr/bin/env python3

"""
test_rsync_folder_operations.py

This script tests the functionality of the rsync_folder_operations.zsh script.
It checks that the rsync command is executed with the correct options for each operation mode ('move', 'copy', 'mirror', 'tmirror').
Also, it tests that the script correctly handles the case where the source and target directories are identical or symbolic links to each other.
"""

import subprocess
import tempfile
import shutil
import unittest
import os

SCRIPT_PATH = os.path.expanduser("~/loadrc/zshrc/rsync_folder_operations.zsh")


class TestRsyncFolderOperations(unittest.TestCase):
    def setUp(self):
        self.source_folder = tempfile.mkdtemp()
        self.target_folder = tempfile.mkdtemp()

    def tearDown(self):
        shutil.rmtree(self.source_folder)
        shutil.rmtree(self.target_folder)
        if os.path.islink(self.target_folder):
            os.unlink(self.target_folder)

    def test_move_mode(self):
        result = subprocess.run(
            [SCRIPT_PATH, self.source_folder, self.target_folder, "move"],
            capture_output=True,
            text=True,
        )
        self.assertIn("--remove-source-files", result.stdout)

    def test_copy_mode(self):
        result = subprocess.run(
            [SCRIPT_PATH, self.source_folder, self.target_folder, "copy"],
            capture_output=True,
            text=True,
        )
        self.assertNotIn("--remove-source-files", result.stdout)
        self.assertNotIn("--delete-before", result.stdout)

    def test_mirror_mode(self):
        result = subprocess.run(
            [SCRIPT_PATH, self.source_folder, self.target_folder, "mirror"],
            capture_output=True,
            text=True,
        )
        self.assertIn("--delete-before", result.stdout)

    def test_tmirror_mode(self):
        result = subprocess.run(
            [SCRIPT_PATH, self.source_folder, self.target_folder, "tmirror"],
            capture_output=True,
            text=True,
        )
        self.assertIn("--delete-before", result.stdout)
        self.assertIn("-in", result.stdout)

    def test_identical_source_and_target(self):
        # Create a new temporary directory, remove it, and make a symlink to the source folder
        temp_dir = tempfile.mkdtemp()
        os.rmdir(temp_dir)
        os.symlink(self.source_folder, temp_dir)

        result = subprocess.run(
            [SCRIPT_PATH, self.source_folder, temp_dir, "copy"],
            capture_output=True,
            text=True,
        )
        self.assertIn(
            "Source and target folders are identical or just soft links to each other. Aborting.",
            result.stdout,
        )

        # Clean up the symlink
        os.unlink(temp_dir)

    def test_source_and_target_are_same(self):
        result = subprocess.run(
            [SCRIPT_PATH, self.source_folder, self.source_folder, "copy"],
            capture_output=True,
            text=True,
        )
        self.assertIn(
            "Source and target folders are identical or just soft links to each other. Aborting.",
            result.stdout,
        )


if __name__ == "__main__":
    unittest.main()
