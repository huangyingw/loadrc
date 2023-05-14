import unittest
from unittest.mock import patch
from rsync_iconv_options import generate_iconv_options, get_remote_encoding


class TestRsyncIconvOptions(unittest.TestCase):
    @patch("sys.platform", "darwin")
    def test_generate_iconv_options_local_mac(self):
        with patch(
            "rsync_iconv_options.get_remote_encoding"
        ) as mock_get_remote_encoding:
            mock_get_remote_encoding.return_value = "utf-8-mac"
            iconv_options = generate_iconv_options(
                "local_source_folder", "local_destination_folder"
            )
            self.assertEqual(iconv_options, "--iconv=utf-8-mac,utf-8-mac")

    @patch("sys.platform", "linux")
    def test_generate_iconv_options_local_linux(self):
        with patch(
            "rsync_iconv_options.get_remote_encoding"
        ) as mock_get_remote_encoding:
            mock_get_remote_encoding.return_value = "utf-8"
            iconv_options = generate_iconv_options(
                "local_source_folder", "local_destination_folder"
            )
            self.assertEqual(iconv_options, "--iconv=utf-8,utf-8")

    def test_get_remote_encoding(self):
        with patch("subprocess.check_output") as mock_check_output:
            mock_check_output.return_value = "Darwin\n"
            result = get_remote_encoding("user@remote_host:/remote/path")
            self.assertEqual(result, "utf-8-mac")
            mock_check_output.return_value = "Linux\n"
            result = get_remote_encoding("user@remote_host:/remote/path")
            self.assertEqual(result, "utf-8")

    def test_generate_iconv_options_linux_to_mac(self):
        with patch("sys.platform", "linux"):
            with patch(
                "rsync_iconv_options.get_remote_encoding"
            ) as mock_get_remote_encoding:
                mock_get_remote_encoding.side_effect = (
                    lambda path: "utf-8"
                    if path == "local_source_folder"
                    else "utf-8-mac"
                )
                iconv_options = generate_iconv_options(
                    "local_source_folder", "user@remote_host:/remote/path"
                )
                self.assertEqual(iconv_options, "--iconv=utf-8,utf-8-mac")

    def test_generate_iconv_options_mac_to_linux(self):
        with patch("sys.platform", "darwin"):
            with patch(
                "rsync_iconv_options.get_remote_encoding"
            ) as mock_get_remote_encoding:
                mock_get_remote_encoding.side_effect = (
                    lambda path: "utf-8-mac"
                    if path == "local_source_folder"
                    else "utf-8"
                )
                iconv_options = generate_iconv_options(
                    "local_source_folder", "user@remote_host:/remote/path"
                )
                self.assertEqual(iconv_options, "--iconv=utf-8-mac,utf-8")


if __name__ == "__main__":
    unittest.main()
