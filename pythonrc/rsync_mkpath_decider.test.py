import unittest
from unittest.mock import patch
import subprocess
import sys
from io import StringIO
from rsync_mkpath_decider import (
    get_rsync_version_command,
    get_rsync_version,
    check_rsync_version,
    decide_mkpath_option,
    main,
    extract_host,
)


class TestRsyncMkpathDecider(unittest.TestCase):
    def test_get_rsync_version_command(self):
        expected_cmd = "rsync --version | head -n 1 | awk '{print $3}'"
        self.assertEqual(get_rsync_version_command(), expected_cmd)

    def test_get_rsync_version_local(self):
        cmd = get_rsync_version_command()
        local_rsync_version = subprocess.check_output(
            cmd, shell=True, text=True
        ).strip()
        self.assertEqual(
            get_rsync_version("./source_folder"), local_rsync_version
        )

    @patch("subprocess.check_output")
    def test_get_rsync_version_remote(self, mock_check_output):
        mock_version = "3.2.0"
        mock_check_output.return_value = mock_version
        source_folder = "user@example.com:/path/to/source_folder"
        self.assertEqual(get_rsync_version(source_folder), mock_version)

    def test_check_rsync_version(self):
        self.assertTrue(check_rsync_version("3.2.0"))
        self.assertTrue(check_rsync_version("3.2.1"))
        self.assertTrue(check_rsync_version("3.3.0"))
        self.assertFalse(check_rsync_version("3.1.9"))
        self.assertFalse(check_rsync_version("2.6.9"))

    @patch("rsync_mkpath_decider.get_rsync_version")
    def test_decide_mkpath_option_newer_to_older(self, mock_get_rsync_version):
        mock_get_rsync_version.side_effect = ["3.2.1", "3.1.9"]
        self.assertEqual(decide_mkpath_option("source", "target"), "")

    @patch("rsync_mkpath_decider.get_rsync_version")
    def test_decide_mkpath_option_older_to_newer(self, mock_get_rsync_version):
        mock_get_rsync_version.side_effect = ["3.1.9", "3.2.1"]
        self.assertEqual(decide_mkpath_option("source", "target"), "--mkpath")


class TestExtractHost(unittest.TestCase):
    def test_extract_host(self):
        self.assertEqual(
            extract_host("user@example.com:/path/to/source_folder"),
            "user@example.com",
        )
        self.assertEqual(
            extract_host("example.com:/path/to/source_folder"), "example.com"
        )
        self.assertEqual(extract_host("mini:~/loadrc/"), "mini")
        self.assertEqual(
            extract_host("/path/to/local/folder"), "/path/to/local/folder"
        )


if __name__ == "__main__":
    unittest.main()
