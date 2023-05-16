import sys
import unittest
from contextlib import contextmanager
from unittest.mock import patch, MagicMock

from rsync_iconv_options import generate_iconv_options, get_remote_encoding


class TestRsyncIconvOptions(unittest.TestCase):
    @patch("rsync_iconv_options.get_local_encoding", return_value="utf-8-mac")
    def test_generate_iconv_options_on_mac(self, mock_get_local_encoding):
        iconv_options = generate_iconv_options(
            "local_source_folder", "local_destination_folder"
        )
        self.assertEqual(iconv_options, "")

    @patch("rsync_iconv_options.get_local_encoding", return_value="utf-8")
    def test_generate_iconv_options_on_linux(self, mock_get_local_encoding):
        iconv_options = generate_iconv_options(
            "local_source_folder", "local_destination_folder"
        )
        self.assertEqual(iconv_options, "")

    @patch("subprocess.check_output")
    def test_get_remote_encoding(self, mock_check_output):
        mock_check_output.return_value = "Darwin\n"
        result = get_remote_encoding("user@remote_host:/remote/path")
        self.assertEqual(result, "utf-8-mac")

        mock_check_output.return_value = "Linux\n"
        result = get_remote_encoding("user@remote_host:/remote/path")
        self.assertEqual(result, "utf-8")

    @patch("rsync_iconv_options.get_local_encoding", return_value="utf-8")
    @patch("rsync_iconv_options.get_remote_encoding", return_value="utf-8-mac")
    def test_generate_iconv_options_from_linux_to_mac(
        self, mock_get_remote_encoding, mock_get_local_encoding
    ):
        iconv_options = generate_iconv_options(
            "local_source_folder", "user@remote_host:/remote/path"
        )
        self.assertEqual(iconv_options, "--iconv=utf-8,utf-8-mac")

    @patch("rsync_iconv_options.get_local_encoding", return_value="utf-8-mac")
    @patch("rsync_iconv_options.get_remote_encoding", return_value="utf-8")
    def test_generate_iconv_options_from_mac_to_linux(
        self, mock_get_remote_encoding, mock_get_local_encoding
    ):
        iconv_options = generate_iconv_options(
            "local_source_folder", "user@remote_host:/remote/path"
        )
        self.assertEqual(iconv_options, "--iconv=utf-8-mac,utf-8")


if __name__ == "__main__":
    unittest.main()
