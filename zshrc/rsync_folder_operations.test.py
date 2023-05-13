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
from unittest.mock import patch, MagicMock
from unittest.mock import patch
import tempfile

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
        self.assertNotIn("--delete-before", result.stdout)
        self.assertNotIn("-in", result.stdout)

    def test_copy_mode(self):
        result = subprocess.run(
            [SCRIPT_PATH, self.source_folder, self.target_folder, "copy"],
            capture_output=True,
            text=True,
        )
        self.assertNotIn("--remove-source-files", result.stdout)
        self.assertNotIn("--delete-before", result.stdout)
        self.assertNotIn("-in", result.stdout)

    def test_mirror_mode(self):
        result = subprocess.run(
            [SCRIPT_PATH, self.source_folder, self.target_folder, "mirror"],
            capture_output=True,
            text=True,
        )
        self.assertIn("--delete-before", result.stdout)
        self.assertNotIn("--remove-source-files", result.stdout)
        self.assertNotIn("-in", result.stdout)

    def test_tmirror_mode(self):
        result = subprocess.run(
            [SCRIPT_PATH, self.source_folder, self.target_folder, "tmirror"],
            capture_output=True,
            text=True,
        )
        self.assertIn("--delete-before", result.stdout)
        self.assertIn("-in", result.stdout)
        self.assertNotIn("--remove-source-files", result.stdout)

    def test_identical_source_and_target(self):
        # Create a new temporary directory, remove it, and make a symlink to the source folder
        temp_dir = tempfile.mkdtemp()
        os.rmdir(temp_dir)
        os.symlink(self.source_folder, temp_dir)

        result = subprocess.run(
            [SCRIPT_PATH, self.source_folder, temp_dir, "move"],
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
            [SCRIPT_PATH, self.source_folder, self.source_folder, "move"],
            capture_output=True,
            text=True,
        )
        self.assertIn(
            "Source and target folders are identical or just soft links to each other. Aborting.",
            result.stdout,
        )

    def test_tmirror_ready_file_created(self):
        result = subprocess.run(
            [SCRIPT_PATH, self.source_folder, self.target_folder, "tmirror"],
            capture_output=True,
            text=True,
        )

        ready_file = os.path.join(self.source_folder, "tmirror.ready")
        self.assertTrue(
            os.path.isfile(ready_file), "tmirror.ready file not created"
        )

        # Clean up the tmirror.ready file
        os.remove(ready_file)

    def test_mkpath_fails_then_succeeds_without_mkpath(self):
        mkpath_failure_triggered = False

        def run_side_effect(*args, **kwargs):
            nonlocal mkpath_failure_triggered
            cmd = args[0]
            print(f"Command received by run_side_effect: {cmd}")
            if "--mkpath" in cmd:
                # Mock the case when rsync with --mkpath fails
                mkpath_failure_triggered = True
                raise FileNotFoundError("Mocked --mkpath failure")
            else:
                # Mock the case when rsync without --mkpath succeeds
                print("Triggering success without --mkpath")
                return subprocess.CompletedProcess(
                    args,
                    returncode=0,
                    stdout="Mocked success without --mkpath",
                    stderr="",
                )
        with patch("subprocess.run", side_effect=run_side_effect):
            cmd = (
                f"{SCRIPT_PATH} {self.source_folder} {self.target_folder} copy"
            )
            output = subprocess.run(
                cmd,
                capture_output=True,
                text=True,
                shell=True,
            )

        print(f"Entire output: {output}")
        self.assertTrue(mkpath_failure_triggered)
        without_mkpath_line_index = output.stdout.find(
            "rsync options (without --mkpath):"
        )
        self.assertNotEqual(without_mkpath_line_index, -1)
        self.assertNotIn("--mkpath", output.stdout[without_mkpath_line_index:])


if __name__ == "__main__":
    unittest.main()
