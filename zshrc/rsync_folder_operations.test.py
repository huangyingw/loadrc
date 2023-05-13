#!/usr/bin/env python3

"""
rsync_folder_operations.test.py

This script tests the functionality of the rsync_folder_operations.zsh script.
It checks that the rsync command is executed with the correct options for each operation mode ('move', 'copy', 'mirror', 'tmirror').
"""

import subprocess
import unittest


class TestRsyncFolderOperations(unittest.TestCase):
    def test_move_mode(self):
        result = subprocess.run(
            [
                "~/loadrc/zshrc/rsync_folder_operations.zsh",
                "source_folder",
                "target_folder",
                "move",
            ],
            capture_output=True,
            text=True,
        )
        self.assertIn("--remove-source-files", result.stdout)

    def test_copy_mode(self):
        result = subprocess.run(
            [
                "~/loadrc/zshrc/rsync_folder_operations.zsh",
                "source_folder",
                "target_folder",
                "copy",
            ],
            capture_output=True,
            text=True,
        )
        self.assertNotIn("--remove-source-files", result.stdout)
        self.assertNotIn("--delete-before", result.stdout)

    def test_mirror_mode(self):
        result = subprocess.run(
            [
                "~/loadrc/zshrc/rsync_folder_operations.zsh",
                "source_folder",
                "target_folder",
                "mirror",
            ],
            capture_output=True,
            text=True,
        )
        self.assertIn("--delete-before", result.stdout)

    def test_tmirror_mode(self):
        result = subprocess.run(
            [
                "~/loadrc/zshrc/rsync_folder_operations.zsh",
                "source_folder",
                "target_folder",
                "tmirror",
            ],
            capture_output=True,
            text=True,
        )
        self.assertIn("--delete-before", result.stdout)
        self.assertIn("-in", result.stdout)


if __name__ == "__main__":
    unittest.main()
