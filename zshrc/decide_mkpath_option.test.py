import unittest
from unittest.mock import patch
import subprocess

SCRIPT_PATH = "~/loadrc/zshrc/decide_mkpath_option.zsh"


class TestDecideMkpathOption(unittest.TestCase):
    def test_local_mkpath_option(self):
        # Test if the --mkpath option is used with local folders
        source_folder = "./source_folder"
        target_folder = "./target_folder"
        output = subprocess.run(
            f"{SCRIPT_PATH} {source_folder} {target_folder}",
            capture_output=True,
            text=True,
            shell=True,
        )

        local_rsync_version = subprocess.run(
            "rsync --version | head -n 1 | awk '{print $3}'",
            capture_output=True,
            text=True,
            shell=True,
        ).stdout.strip()

        if float(local_rsync_version) >= 3.2:
            self.assertEqual(output.stdout.strip(), "--mkpath")
        else:
            self.assertEqual(output.stdout.strip(), "")

    @patch("subprocess.run")
    def test_remote_mkpath_option(self, mock_run):
        # Test if the --mkpath option is used with remote folders
        # Mock the response of the ssh command
        mock_run.return_value.stdout.strip.return_value = "3.2.0"

        source_folder = "user@example.com:/path/to/source_folder"
        target_folder = "user@example.com:/path/to/target_folder"
        output = subprocess.run(
            f"{SCRIPT_PATH} {source_folder} {target_folder}",
            capture_output=True,
            text=True,
            shell=True,
        )

        remote_rsync_version = subprocess.run(
            f"ssh {source_folder.split(':')[0]} 'rsync --version' | head -n 1 | awk '{{print $3}}'",
            capture_output=True,
            text=True,
            shell=True,
        ).stdout.strip()

        if float(remote_rsync_version) >= 3.2:
            self.assertEqual(output.stdout.strip(), "--mkpath")
        else:
            self.assertEqual(output.stdout.strip(), "")

    @patch("subprocess.run")
    def test_get_rsync_version(self, mock_run):
        # Mock the ssh response
        mock_run.return_value.stdout.strip.return_value = "3.2.0"

        source_folder = "user@example.com:/path/to/source_folder"
        target_folder = "user@example.com:/path/to/target_folder"

        host = source_folder.split(":")[0]
        remote_rsync_version = subprocess.run(
            f"source {SCRIPT_PATH}; get_rsync_version {host}",
            capture_output=True,
            text=True,
            shell=True,
        ).stdout.strip()

        self.assertEqual(float(remote_rsync_version), 3.2)


if __name__ == "__main__":
    unittest.main()
